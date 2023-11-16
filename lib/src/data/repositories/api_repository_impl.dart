import 'package:injectable/injectable.dart';
import '../../domain/models/requests/add_category_request.dart';
import '../../domain/models/responses/custom_response.dart';
import '../../domain/models/responses/get_categories_response.dart';
import '../../domain/models/responses/get_rayons_response.dart';
import '../../domain/models/responses/login_response.dart';
import '../data_sources/remote/auth_service.dart';
import '../data_sources/remote/qr_code_api_service.dart';
import '../../domain/models/requests/generate_qr_request.dart';
import '../../domain/models/responses/generate_qr_response.dart';
import '../../domain/repositories/api_repository.dart';
import '../../utils/resources/data_state.dart';
import '../base/base_api_repository.dart';
import '../data_sources/remote/store_settings_service.dart';

@LazySingleton(as: ApiRepository)
class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final QrCodeApiService _qrCodeApiService;
  final AuthService _authService;
  final StoreSettingsService _storeSettingsService;
  ApiRepositoryImpl(
      this._qrCodeApiService, this._authService, this._storeSettingsService);
  @override
  Future<DataState<GenerateQrResponse>> generateQrCode(
      {required GenerateQrRequest request}) async {
    var x = await getStateOf<GenerateQrResponse>(
      request: () => _qrCodeApiService.generateQrCode(
        reyon: request.reyon,
        category: request.category,
        productId: request.productId,
        company: request.company,
      ),
    );
    return x;
  }

  @override
  Future<DataState<LoginResponse>> login(
      {required String email, required String password}) {
    return getStateOf(
      request: () => _authService.login(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<DataState<CustomResponse>> addCategory(
      {required AddCategoryRequest request}) {
    return getStateOf(
      request: () => _storeSettingsService.addCategory(
        categoryname: request.categoryname,
        companyid: request.companyid,
      ),
    );
  }

  @override
  Future<DataState<GetCategoriesResponse>> getCategories(
      {required int companyid}) {
    return getStateOf(
      request: () => _storeSettingsService.getCategories(
        companyid: companyid,
      ),
    );
  }

  @override
  Future<DataState<CustomResponse>> deleteCategory({required int categoryid}) {
    return getStateOf(
      request: () => _storeSettingsService.deleteCategory(
        categoryid: categoryid,
      ),
    );
  }

  @override
  Future<DataState<CustomResponse>> addReyon(
      {required int categoryid,
      required String rayonname,
      required int companyid}) {
    return getStateOf(
      request: () => _storeSettingsService.addReyon(
        categoryid: categoryid,
        rayonname: rayonname,
        companyid: companyid,
      ),
    );
  }

  @override
  Future<DataState<GetRayonsResponse>> getRayons({required int companyid}) {
    return getStateOf(
      request: () => _storeSettingsService.getRayons(
        companyid: companyid,
      ),
    );
  }
}
