import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:weight_tracker/src/core/utils/logger_util.dart';

import '../../../../../../core/services/network/response_status.dart';
import '../../../../auth/logic/model/user_model.dart';

part 'crud_weight_event.dart';
part 'crud_weight_state.dart';

class CrudWeightBloc extends Bloc<CrudWeightEvent, CrudWeightState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CrudWeightBloc() : super(const CrudWeightState()) {
    on<CreateNewWeight>(_onCreateNewWeight);
    on<FetchAllWeight>(_onFetchAllWeight);
    on<UpdateMyWeight>(_onUpdateMyWeight);
    on<DeleteMyWeight>(_onDeleteWeight);
    on<Reset>(_onReset);
  }

  void _onCreateNewWeight(
      CreateNewWeight event, Emitter<CrudWeightState> emit) async {
    emit(
      state.copyWith(
        status: const ResponseStatus.loading(),
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
          status: const ResponseStatus.success(),
        ),
      );
    });
  }

  void fetchAllWeights() {
    final List<UserModel> users = [];

    _firestore.collection("users").snapshots().listen((event) {
      for (var doc in event.docs) {
        doc.data().logWtf('from listner');
        final user = UserModel.fromJson(doc.data());
        users.add(user);
      }
      add(FetchAllWeight(users: users));
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
          users: event.users ?? users,
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
    add(FetchAllWeight());
  }

  void _onReset(Reset event, Emitter<CrudWeightState> emit) {
    emit(
      state.copyWith(
        updateStatus: const ResponseStatus.initial(),
        status: const ResponseStatus.initial(),
        deleteStatus: const ResponseStatus.initial(),
        users: null,
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
    add(FetchAllWeight());
  }
}
