import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/responses/login_response.dart';

import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/database_repository.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';

part 'login_states.dart';

@injectable
class LoginCubit extends BaseCubit<LoginState, LoginResponse?> {
  final ApiRepository _apiRepository;
  final DatabaseRepository _databaseRepository;
  LoginCubit(
    this._apiRepository,
    this._databaseRepository,
  ) : super(const LoginInitial(), null);

  Future<void> login({required String email, required String password}) async {
    if (isBusy) return;

    await run(
      () async {
        emit(const LoginLoading());
        final response = await _apiRepository.login(
          email: email,
          password: password,
        );

        if (response is DataSuccess) {
          await saveDb(user: response.data!.data!);
          emit(LoginSuccess(user: response.data));
        } else if (response is DataFailed) {
          emit(LoginFailed(error: response.error));
        }
      },
    );
  }

  Future<void> saveDb({required UserData user}) async {
    await _databaseRepository.setUser(user);
  }
}
