part of 'app_cubit.dart';

class AppState extends Equatable {
  final bool isDark;

  const AppState({
    this.isDark = false,
  });

  @override
  List<Object?> get props => [isDark];
}
