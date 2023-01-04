part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = const ResponseStatus.initial(),
    this.message = '',
    this.user,
  });
  final ResponseStatus status;
  final String message;
  final UserModel? user;
  LoginState copyWith({
    ResponseStatus? status,
    String? message,
    UserModel? user,
  }) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
      user : user ?? this.user,
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
