import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../utils/enums/navigation_bar_item.dart';

part 'navigation_states.dart';

@singleton
class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
      : super(const NavigationState(
            pageIndex: 0, navBarItem: NavBarItem.settings));

  void setIndex(int index) {
    switch (index) {
      case 0:
        emit(const NavigationState(
            navBarItem: NavBarItem.settings, pageIndex: 0));
        break;
      case 1:
        emit(const NavigationState(navBarItem: NavBarItem.read, pageIndex: 1));
        break;
      case 2:
        emit(
            const NavigationState(navBarItem: NavBarItem.create, pageIndex: 2));
        break;
    }
  }
}
