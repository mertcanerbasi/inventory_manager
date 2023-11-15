import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/responses/login_response.dart';
import '../../../domain/repositories/database_repository.dart';

@injectable
class SplashCubit extends Cubit<bool> {
  final DatabaseRepository _databaseRepository;
  SplashCubit(this._databaseRepository) : super(false);
  UserData? get user => _databaseRepository.user;

  /// This method is used to check if the user is logged in or not.
  /// If the user is logged in, it will be redirected to the home page.
  Future<bool> checkUser() async {
    //_databaseRepository.clear();
    await Future.delayed(const Duration(seconds: 1));

    if (user != null) {
      return true;
    } else {
      return false;
    }
  }
}
