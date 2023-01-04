part of 'crud_weight_bloc.dart';

class CrudWeightState extends Equatable {
  const CrudWeightState({
    this.status = const ResponseStatus.initial(),
    this.updateStatus = const ResponseStatus.initial(),
    this.deleteStatus = const ResponseStatus.initial(),
    this.message = '',
    this.users = const [],
  });
  final ResponseStatus status;
  final ResponseStatus updateStatus;
  final ResponseStatus deleteStatus;
  final String message;
  final List<UserModel> users;
  CrudWeightState copyWith({
    ResponseStatus? status,
    ResponseStatus? updateStatus,
    ResponseStatus? deleteStatus,
    String? message,
    List<UserModel>? users,
  }) {
    return CrudWeightState(
      status: status ?? this.status,
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      message: message ?? this.message,
      users: users ?? this.users,
      //-- : -- ?? this.--,
    );
  }

  @override
  List<Object?> get props => [
        status,
        updateStatus,
        deleteStatus,
        message,
        users,
      ];
}
