import 'package:injectable/injectable.dart';
import '../../domain/models/responses/login_response.dart';
import '../data_sources/remote/auth_service.dart';
import '../data_sources/remote/qr_code_api_service.dart';
import '../../domain/models/requests/generate_qr_request.dart';
import '../../domain/models/responses/generate_qr_response.dart';
import '../../domain/repositories/api_repository.dart';
import '../../utils/resources/data_state.dart';
import '../base/base_api_repository.dart';

@LazySingleton(as: ApiRepository)
class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final QrCodeApiService _qrCodeApiService;
  final AuthService _authService;
  ApiRepositoryImpl(this._qrCodeApiService, this._authService);
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
}
