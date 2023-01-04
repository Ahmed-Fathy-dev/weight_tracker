import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:weight_tracker/src/app/features/home/logic/model/weight_model.dart';
import 'package:weight_tracker/src/core/utils/logger_util.dart';

import '../../../../../../core/services/local_storage/box_storage.dart';
import '../../../../../../core/services/network/response_status.dart';
import '../../../../auth/logic/model/user_model.dart';

part 'crud_weight_event.dart';
part 'crud_weight_state.dart';

class CrudWeightBloc extends Bloc<CrudWeightEvent, CrudWeightState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userBox = Boxes.getCashedUserModel();

  CrudWeightBloc() : super(const CrudWeightState()) {
    on<CreateNewWeight>(_onCreateNewWeight);
    on<FetchAllWeight>(_onFetchAllWeight);
    on<ReFetchAllWeight>(_onReFetchAllWeight);
    on<UpdateMyWeight>(_onUpdateMyWeight);
    on<DeleteMyWeight>(_onDeleteWeight);
    on<WeightsPaginationEvent>(_onPaginationEvent);
    on<GetFromCach>(_onGetFromCach);
    on<CanCreate>(_onCanCreate);
    on<Reset>(_onReset);
  }

  void _onCreateNewWeight(
      CreateNewWeight event, Emitter<CrudWeightState> emit) async {
    emit(
      state.copyWith(
        updateStatus: const ResponseStatus.loading(),
      ),
    );
    final userWeightDoc = _firestore
        .collection('users')
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, options) => user.toFirestore(),
        )
        .doc(event.userWeight.id);

    await userWeightDoc.set(event.userWeight).then((_) {
      logger.wtf('success');

      emit(
        state.copyWith(
          updateStatus: const ResponseStatus.success(),
          message: 'Update Successfully',
        ),
      );
      _fetchAllWeights();
    });
  }

  void _fetchAllWeights() {
    final List<UserModel> users = [];

    _firestore
        .collection("users")
        .orderBy('weight.time', descending: true)
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        doc.data().logWtf('from listner');
        final user = UserModel.fromJson(doc.data());
        users.add(user);
      }
      add(ReFetchAllWeight(users: users));
      users.logD('users after fromjson from listner FetchAllWeight bloc');
    }, onError: (error) {
      error.toString().logE('error from listener');
    });
  }

  void _onFetchAllWeight(
      FetchAllWeight event, Emitter<CrudWeightState> emit) async {
    final List<UserModel> users = [];

    emit(
      state.copyWith(
        status: const ResponseStatus.loading(),
      ),
    );
    final userWeightDocs =
        _firestore.collection('users') /* .orderBy('time').limit(7) */;
    logger.wtf("from bloc");
    final docsSnap = await userWeightDocs
        .limit(7)
        .orderBy('weight.time', descending: true)
        .get();
    docsSnap.docs.logD('docsSnap.docs after fromjson from fetch bloc');

    for (var userM in docsSnap.docs) {
      final user = UserModel.fromJson(userM.data());
      users.add(user);
      emit(
        state.copyWith(
          status: const ResponseStatus.success(),
          users: users,
        ),
      );
    }
    users.logD('users after fromjson from fetch bloc');
  }

  void _onUpdateMyWeight(
      UpdateMyWeight event, Emitter<CrudWeightState> emit) async {
    emit(
      state.copyWith(
        updateStatus: const ResponseStatus.loading(),
      ),
    );
    event.userWeight.logD('event.userWeight');
    final weightRef = _firestore.collection("users").doc(event.userWeight.id);
    await weightRef.update({
      "weight.weight": event.userWeight.weightModel!.weight,
    }).then(
      (_) {},
      onError: (e) => e.toString().logE('error from update'),
    );
    emit(
      state.copyWith(
          updateStatus: const ResponseStatus.success(),
          message: 'Update Successfully'),
    );
    _fetchAllWeights();
  }

  void _onReset(Reset event, Emitter<CrudWeightState> emit) {
    emit(
      state.copyWith(
        updateStatus: const ResponseStatus.initial(),
        status: const ResponseStatus.initial(),
        deleteStatus: const ResponseStatus.initial(),
        users: null,
        user: null,
        message: '',
      ),
    );
  }

  FutureOr<void> _onDeleteWeight(
      DeleteMyWeight event, Emitter<CrudWeightState> emit) async {
    emit(
      state.copyWith(
        deleteStatus: const ResponseStatus.loading(),
      ),
    );
    event.userWeight.logD('event.userWeight');
    final weightRef = _firestore.collection("users").doc(event.userWeight.id);
    await weightRef.delete().then(
      (_) {
        state.users.removeWhere((element) => event.userWeight.id == element.id);
      },
      onError: (e) {
        // state.users.add(event.userWeight);
        e.toString().logE('error from update');
      },
    );
    emit(
      state.copyWith(
          deleteStatus: const ResponseStatus.success(),
          message: 'Delete Successfully'),
    );
    _fetchAllWeights();
  }

  void onPagination() async {
    int length = state.users.length;

    final next = _firestore
        .collection("users")
        .orderBy('weight.time', descending: true)
        .startAfter([length]).limit(7);

    next.get().then((value) {
      add(Reset());
      for (var userM in value.docs) {
        final user = UserModel.fromJson(userM.data());
        // state.users.add(user);
        add(WeightsPaginationEvent(user));
      }
    });
  }

  void _onReFetchAllWeight(
      ReFetchAllWeight event, Emitter<CrudWeightState> emit) {
    add(Reset());
    emit(state.copyWith(users: event.users));
  }

  FutureOr<void> _onPaginationEvent(
      WeightsPaginationEvent event, Emitter<CrudWeightState> emit) {
    emit(
      state.copyWith(
        paginationStatus: const ResponseStatus.loading(),
      ),
    );
    final users = List.of(state.users)..add(event.usersWeights);
    emit(
      state.copyWith(
        paginationStatus: const ResponseStatus.success(),
        users: users,
      ),
    );
  }

  void _onGetFromCach(GetFromCach event, Emitter<CrudWeightState> emit) async {
    final userM = userBox.get(userMKey);
    emit(
      state.copyWith(
        user: UserModel(
          id: userM!.id,
          name: userM.name,
          token: userM.token,
          weightModel: WeightModel(
              id: userM.weightId!,
              weight: userM.weight,
              time: DateTime.parse(userM.time)),
        ),
      ),
    );
  }

  void _onCanCreate(CanCreate event, Emitter<CrudWeightState> emit) {
    emit(state.copyWith(canCreate: event.canCreateStatus));
  }
}
