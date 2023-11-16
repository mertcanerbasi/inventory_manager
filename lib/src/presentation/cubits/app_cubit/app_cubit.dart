import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repositories/database_repository.dart';
part 'app_states.dart';

@singleton
@injectable
class AppCubit extends Cubit<AppState> {
  final DatabaseRepository _databaseRepository;
  AppCubit(this._databaseRepository) : super(const AppState());

  void changeTheme() {
    emit(AppState(isDark: !state.isDark));
  }

  Future logout() async {
    await _databaseRepository.clear();
  }
}
