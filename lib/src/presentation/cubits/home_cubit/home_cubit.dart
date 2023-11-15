import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/models/requests/add_category_request.dart';
import '../../../domain/models/responses/custom_response.dart';
import '../../../domain/models/responses/login_response.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/database_repository.dart';
import '../base/base_cubit.dart';
import '../../../utils/resources/data_state.dart';

part 'home_states.dart';

@injectable
class HomeCubit extends BaseCubit<HomeState, HomeViewData> {
  final ApiRepository _apiRepository;
  final DatabaseRepository _databaseRepository;

  HomeCubit(this._apiRepository, this._databaseRepository)
      : super(const HomeCreate(), const HomeViewData());

  UserData get userData => _databaseRepository.user!;

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

        if (response is DataSuccess) {
          emit(HomeSuccess(
              homeViewData: HomeViewData(addCategoryResponse: response.data)));
        } else if (response is DataFailed) {
          emit(HomeFailed(error: response.error));
        }
      },
    );
  }
}
