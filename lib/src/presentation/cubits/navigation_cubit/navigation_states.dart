part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final NavBarItem navBarItem;
  final int pageIndex;
  const NavigationState({
    required this.pageIndex,
    required this.navBarItem,
  });

  @override
  List<Object> get props => [navBarItem, pageIndex];
}
