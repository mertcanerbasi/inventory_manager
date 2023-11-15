// Package imports:

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:injectable/injectable.dart';
import 'data/data_sources/remote/store_settings_service.dart';
import 'utils/interceptors/error_interceptor.dart';
import 'utils/interceptors/log_interceptor.dart';
import 'utils/interceptors/token_interceptor.dart';
import 'data/data_sources/remote/auth_service.dart';
import 'data/data_sources/remote/qr_code_api_service.dart';
import 'utils/constants/app_strings.dart';

// Project imports:

@module
abstract class AppModule {
  @Environment(Environment.dev)
  @Environment(Environment.prod)
  @Environment(Environment.test)
  @lazySingleton
  Dio get injectRetrofitAPI {
    Dio dio = Dio(
      BaseOptions(baseUrl: AppStrings.baseUrl, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      }
          // connectTimeout: 10000,
          // receiveTimeout: 10000,
          // sendTimeout: 10000,
          ),
    );

    dio.interceptors.add(TokenInterceptor());
    if (kDebugMode) {
      dio.interceptors.add(LoggerInterceptor());
      // dio.interceptors.add(PrettyDioLogger(
      //   requestHeader: true,
      //   requestBody: true,
      //   responseHeader: true,
      // ));
    }

    dio.interceptors.add(ErrorInterceptor());

    return dio;
  }

  @lazySingleton
  QrCodeApiService get injectApiService => QrCodeApiService(
        injectRetrofitAPI,
      );
  @lazySingleton
  AuthService get injectAuthService => AuthService(injectRetrofitAPI);

  @lazySingleton
  StoreSettingsService get injectStoreSettingsService =>
      StoreSettingsService(injectRetrofitAPI);

  @singleton
  final GlobalKey<NavigatorState> mainNavigatorKey =
      GlobalKey<NavigatorState>();

  @preResolve
  Future<GetStorage> get initializeGetStorage async {
    // init future olarak tanımladığı için önce init edip sonra objeyi çağrıyoruz.
    var storageName = "store1";
    await GetStorage.init(storageName);
    return GetStorage(storageName);
  }
}
