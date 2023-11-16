part of 'home_cubit.dart';

class HomeViewData {
  final CustomResponse? addCategoryResponse;
  final GetCategoriesResponse? getCategoriesResponse;
  final CustomResponse? deleteCategoryResponse;
  final CustomResponse? addRayonResponse;
  final GetRayonsResponse? getRayonsResponse;
  final DioException? error;
  const HomeViewData({
    this.addCategoryResponse,
    this.getCategoriesResponse,
    this.deleteCategoryResponse,
    this.addRayonResponse,
    this.getRayonsResponse,
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
  HomeSuccess({CustomResponse? addCategoryResponse})
      : super(
            homeViewData:
                HomeViewData(addCategoryResponse: addCategoryResponse));
}

final class HomeFailed extends HomeState {
  const HomeFailed({super.error});
}

final class HomeCreate extends HomeState {
  HomeCreate(
      {GetCategoriesResponse? getCategoriesResponse,
      CustomResponse? deleteCategoryResponse,
      CustomResponse? addRayonResponse,
      GetRayonsResponse? getRayonsResponse})
      : super(
            homeViewData: HomeViewData(
                getCategoriesResponse: getCategoriesResponse,
                deleteCategoryResponse: deleteCategoryResponse,
                addRayonResponse: addRayonResponse,
                getRayonsResponse: getRayonsResponse));
}
