part of 'home_cubit.dart';

class HomeViewData {
  final CustomResponse? addCategoryResponse;
  final DioException? error;
  const HomeViewData({
    this.addCategoryResponse,
    this.error,
  });
}

abstract class HomeState extends Equatable {
  final HomeViewData? homeViewData;
  final DioException? error;
  const HomeState({
    this.homeViewData,
    this.error,
  });

  @override
  List<Object?> get props => [homeViewData, error];
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeSuccess extends HomeState {
  const HomeSuccess({super.homeViewData});
}

final class HomeFailed extends HomeState {
  const HomeFailed({super.error});
}

final class HomeCreate extends HomeState {
  const HomeCreate();
}
