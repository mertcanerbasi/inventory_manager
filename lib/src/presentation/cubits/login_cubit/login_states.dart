part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  final LoginResponse? user;
  final DioException? error;
  const LoginState({
    this.user,
    this.error,
  });

  @override
  List<Object?> get props => [user, error];
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginSuccess extends LoginState {
  const LoginSuccess({super.user});
}

final class LoginFailed extends LoginState {
  const LoginFailed({super.error});
}

final class HomeCreate extends LoginState {
  const HomeCreate();
}
