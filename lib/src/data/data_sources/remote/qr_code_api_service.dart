import 'package:dio/dio.dart';

import '../../../domain/models/responses/generate_qr_response.dart';
import 'package:retrofit/retrofit.dart';

part 'qr_code_api_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class QrCodeApiService {
  factory QrCodeApiService(Dio dio, {String baseUrl}) = _QrCodeApiService;

  @POST('/generate')
  Future<HttpResponse<GenerateQrResponse>> generateQrCode({
    @Field('reyon') required String reyon,
    @Field('category') required String category,
    @Field('productId') required String productId,
    @Field('company') required int company,
  });
}
