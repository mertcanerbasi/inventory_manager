import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/models/responses/get_categories_response.dart';
import '../../../domain/models/requests/add_category_request.dart';
import '../../../domain/models/responses/custom_response.dart';
import '../../../domain/models/responses/get_rayons_response.dart';
import '../../../domain/models/responses/login_response.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/database_repository.dart';
import '../base/base_cubit.dart';
import '../../../utils/resources/data_state.dart';

part 'home_states.dart';

@injectable
class HomeCubit extends BaseCubit<HomeState, HomeViewData?> {
  final ApiRepository _apiRepository;
  final DatabaseRepository _databaseRepository;

  HomeCubit(this._apiRepository, this._databaseRepository)
      : super(HomeCreate(), null);

  UserData get userData => _databaseRepository.user!;

  CustomResponse? addCategoryResponse;
  CustomResponse? addRayonResponse;
  GetCategoriesResponse? getCategoriesResponse;
  GetRayonsResponse? getRayonsResponse;
  CustomResponse? deleteCategoryResponse;

  Future<void> addCategory({required String categoryName}) async {
    if (isBusy) return;

    await run(
      () async {
        emit(const HomeLoading());
        final response = await _apiRepository.addCategory(
          request: AddCategoryRequest(
            categoryname: categoryName.toUpperCase(),
            companyid: userData.company,
          ),
        );

        addCategoryResponse = response.data;

        if (response is DataSuccess) {
          emit(HomeSuccess(addCategoryResponse: response.data));
        } else if (response is DataFailed) {
          emit(HomeFailed(error: response.error));
        }
      },
    );
  }

  Future<void> getCategories() async {
    if (isBusy) return;

    await run(
      () async {
        emit(const HomeLoading());
        final response = await _apiRepository.getCategories(
          companyid: userData.company,
        );

        getCategoriesResponse = response.data;
        _databaseRepository
            .setCategories(getCategoriesResponse!.data!.categories!);

        if (response is DataSuccess) {
          emit(HomeCreate(getCategoriesResponse: response.data));
        } else if (response is DataFailed) {
          emit(HomeFailed(error: response.error));
        }
      },
    );
  }

  Future<void> deleteCategory({required int categoryid}) async {
    if (isBusy) return;

    await run(
      () async {
        emit(const HomeLoading());
        final response =
            await _apiRepository.deleteCategory(categoryid: categoryid);

        deleteCategoryResponse = response.data;

        if (response is DataSuccess) {
          emit(HomeCreate(deleteCategoryResponse: response.data));
        } else if (response is DataFailed) {
          emit(HomeFailed(error: response.error));
        }
      },
    );
  }

  Future<void> addRayon(
      {required int categoryid, required String rayonname}) async {
    if (isBusy) return;

    await run(
      () async {
        emit(const HomeLoading());
        final response = await _apiRepository.addReyon(
            categoryid: categoryid,
            rayonname: rayonname.toUpperCase(),
            companyid: userData.company);

        addRayonResponse = response.data;

        if (response is DataSuccess) {
          emit(HomeCreate(deleteCategoryResponse: response.data));
        } else if (response is DataFailed) {
          emit(HomeFailed(error: response.error));
        }
      },
    );
  }

  Future<void> getRayons() async {
    if (isBusy) return;

    await run(
      () async {
        emit(const HomeLoading());
        final response = await _apiRepository.getRayons(
          companyid: userData.company,
        );

        getRayonsResponse = response.data;
        _databaseRepository.setRayons(getRayonsResponse!.data!.rayons!);

        if (response is DataSuccess) {
          emit(HomeCreate(getRayonsResponse: response.data));
        } else if (response is DataFailed) {
          emit(HomeFailed(error: response.error));
        }
      },
    );
  }
}
