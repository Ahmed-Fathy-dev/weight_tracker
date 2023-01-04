part of 'crud_weight_bloc.dart';

class CrudWeightEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateNewWeight extends CrudWeightEvent {
  final UserModel userWeight;

  CreateNewWeight(this.userWeight);
  @override
  List<Object?> get props => [userWeight];
}

class FetchAllWeight extends CrudWeightEvent {
  final List<UserModel>? users;

  FetchAllWeight({
    this.users,
  });
  @override
  List<Object?> get props => [users];
}

class ReFetchAllWeight extends CrudWeightEvent {
  final List<UserModel>? users;

  ReFetchAllWeight({
    this.users,
  });
  @override
  List<Object?> get props => [users];
}

class UpdateMyWeight extends CrudWeightEvent {
  final UserModel userWeight;

  UpdateMyWeight(this.userWeight);

  @override
  List<Object?> get props => [userWeight];
}

class DeleteMyWeight extends CrudWeightEvent {
  final UserModel userWeight;

  DeleteMyWeight(this.userWeight);

  @override
  List<Object?> get props => [userWeight];
}

class WeightsPaginationEvent extends CrudWeightEvent {
  final UserModel usersWeights;

  WeightsPaginationEvent(this.usersWeights);

  @override
  List<Object?> get props => [usersWeights];
}

class GetFromCach extends CrudWeightEvent {}

class CanCreate extends CrudWeightEvent {
  final bool canCreateStatus;

  CanCreate(this.canCreateStatus);

  @override
  List<Object?> get props => [canCreateStatus];
}

class Reset extends CrudWeightEvent {}
