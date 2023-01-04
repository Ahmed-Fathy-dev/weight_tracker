import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
        .doc();

    await userWeightDoc.set(event.userWeight).then((_) {
      logger.wtf('success');
      emit(
        state.copyWith(
          status: const ResponseStatus.success(),
        ),
      );
    });
  }

  void _onFetchAllWeight(FetchAllWeight event, Emitter<CrudWeightState> emit) {
    emit(
      state.copyWith(
        status: const ResponseStatus.loading(),
      ),
    );
    logger.wtf("from bloc");
    _firestore.collection("users").snapshots().listen((event) {
      final List<UserModel> users = [];
      for (var doc in event.docs) {
        doc.data().logWtf('from listner');
        final user = UserModel.fromJson(doc.data());
        users.add(user);
      }
      users.logD('users after fromjson from listner FetchAllWeight bloc');
      emit(
        state.copyWith(
          status: const ResponseStatus.success(),
          users: users,
        ),
      );
    }, onError: (error) {
      error.toString().logE('error from listener');
    });
  }
}
