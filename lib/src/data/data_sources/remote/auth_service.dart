import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';

import '../../../domain/models/responses/login_response.dart';

part 'auth_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('/login')
  Future<HttpResponse<LoginResponse>> login({
    @Field('email') required String email,
    @Field('password') required String password,
  });
}
