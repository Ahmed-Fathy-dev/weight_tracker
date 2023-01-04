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

class FetchAllWeight extends CrudWeightEvent {}

class UpdateMyWeight extends CrudWeightEvent {
  @override
  List<Object?> get props => [];
}

class DeleteMyWeight extends CrudWeightEvent {
  @override
  List<Object?> get props => [];
}
