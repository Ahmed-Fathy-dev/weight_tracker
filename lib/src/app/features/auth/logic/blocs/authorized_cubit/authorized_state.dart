

part of 'authorized_cubit.dart';

class AuthorizedState extends Equatable {
  const AuthorizedState({
    this.status = const ResponseStatus.initial(),
    this.message = '',
    this.user,
  });
  final ResponseStatus status;
  final String message;
  final UserModel? user;
  AuthorizedState copyWith({
    ResponseStatus? status,
    String? message,
    UserModel? user,
  }) {
    return AuthorizedState(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
      //-- : -- ?? this.--,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        user,
      ];
}
