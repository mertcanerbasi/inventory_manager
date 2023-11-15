import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'app_states.dart';

@singleton
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  void changeTheme() {
    emit(AppState(isDark: !state.isDark));
  }
}
