part of 'crud_weight_bloc.dart';

class CrudWeightState extends Equatable {
  const CrudWeightState({
    this.status = const ResponseStatus.initial(),
    this.message = '',
    this.users = const [],
  });
  final ResponseStatus status;
  final String message;
  final List<UserModel> users;
  CrudWeightState copyWith({
    ResponseStatus? status,
    String? message,
    List<UserModel>? users,
  }) {
    return CrudWeightState(
      status: status ?? this.status,
      message: message ?? this.message,
      users: users ?? this.users,
      //-- : -- ?? this.--,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        users,
      ];
}
