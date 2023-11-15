import '../models/requests/generate_qr_request.dart';
import '../models/responses/generate_qr_response.dart';
import '../../utils/resources/data_state.dart';
import '../models/responses/login_response.dart';

abstract class ApiRepository {
  Future<DataState<GenerateQrResponse>> generateQrCode({
    required GenerateQrRequest request,
  });

  Future<DataState<LoginResponse>> login({
    required String email,
    required String password,
  });
}
