part of 'crud_weight_bloc.dart';

class CrudWeightState extends Equatable {
  const CrudWeightState({
    this.status = const ResponseStatus.initial(),
    this.updateStatus = const ResponseStatus.initial(),
    this.deleteStatus = const ResponseStatus.initial(),
    this.paginationStatus = const ResponseStatus.initial(),
    this.message = '',
    this.hasReachMax = false,
    this.user,
    this.users = const [],
    this.canCreate = true,
  });
  final ResponseStatus status;
  final ResponseStatus updateStatus;
  final ResponseStatus deleteStatus;
  final ResponseStatus paginationStatus;
  final UserModel? user;
  final String message;
  final bool hasReachMax;
  final List<UserModel> users;
  final bool canCreate;
  CrudWeightState copyWith({
    ResponseStatus? status,
    ResponseStatus? updateStatus,
    ResponseStatus? deleteStatus,
    ResponseStatus? paginationStatus,
    UserModel? user,
    String? message,
    bool? hasReachMax,
    List<UserModel>? users,
    bool? canCreate,
  }) {
    return CrudWeightState(
      status: status ?? this.status,
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      message: message ?? this.message,
      users: users ?? this.users,
      hasReachMax: hasReachMax ?? this.hasReachMax,
      paginationStatus: paginationStatus ?? this.paginationStatus,
      user: user ?? this.user,
      canCreate: canCreate ?? this.canCreate,
    );
  }

  @override
  List<Object?> get props => [
        status,
        updateStatus,
        deleteStatus,
        message,
        hasReachMax,
        paginationStatus,
        user,
        canCreate,
        users,
      ];
}
