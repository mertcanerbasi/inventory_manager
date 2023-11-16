import 'package:dio/dio.dart';

import '../../../domain/models/responses/custom_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/models/responses/get_categories_response.dart';

part 'store_settings_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class StoreSettingsService {
  factory StoreSettingsService(Dio dio, {String baseUrl}) =
      _StoreSettingsService;

  @POST('/add-category')
  Future<HttpResponse<CustomResponse>> addCategory({
    @Field('categoryname') required String categoryname,
    @Field('companyid') required int companyid,
  });

  @POST('/get-categories')
  Future<HttpResponse<GetCategoriesResponse>> getCategories({
    @Field('companyid') required int companyid,
  });

  @POST('/delete-category')
  Future<HttpResponse<CustomResponse>> deleteCategory({
    @Field('categoryid') required int categoryid,
  });
}
