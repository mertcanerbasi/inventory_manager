// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../../config/router/router.routes.dart';
import '../../domain/repositories/database_repository.dart';
import '../../locator.dart';
import '../constants/app_strings.dart';
import '../extensions/object_extensions.dart';
import 'log_interceptor.dart';

//https://github.com/flutterchina/dio
class TokenInterceptor extends QueuedInterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var localDataSource = getIt<DatabaseRepository>();
    if (localDataSource.isUserLoggedIn) {
      options.headers['Authorization'] =
          "Bearer ${localDataSource.user!.accessToken}";
      //localDataSource.clear();
      // getIt<AppRoute>().mainNavigatorKey.currentContext?.let((it) {
      //   Navigator.pushNamedAndRemoveUntil(it, "splash", (route) => false);
      // });
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    var localDataSource = getIt<DatabaseRepository>();
    if (err.response?.statusCode == 401) {
      try {
        var dio = Dio();
        if (kDebugMode) {
          dio.interceptors.add(LoggerInterceptor());
        }
        Response response =
            await dio.post("${AppStrings.baseUrl}refresh-token", data: {
          "refreshToken": localDataSource.user!.refreshToken,
        }).then((result) async {
          final res = result.data!["data"]["accessToken"];
          await localDataSource.setAccessToken(res);
          return result;
        });
        if (response.statusCode == 200) {
          String newAccessToken = response.data!["data"]["accessToken"];
          err.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';

          var retriedResponse = await dio.request(
            "${AppStrings.baseUrl.substring(0, AppStrings.baseUrl.length - 1)}${err.requestOptions.path}",
            options: Options(
              contentType: err.requestOptions.contentType,
              headers: err.requestOptions.headers,
              method: err.requestOptions.method,
              responseType: err.requestOptions.responseType,
              sendTimeout: err.requestOptions.sendTimeout,
              receiveTimeout: err.requestOptions.receiveTimeout,
              extra: err.requestOptions.extra,
              validateStatus: err.requestOptions.validateStatus,
              receiveDataWhenStatusError:
                  err.requestOptions.receiveDataWhenStatusError,
              followRedirects: err.requestOptions.followRedirects,
              maxRedirects: err.requestOptions.maxRedirects,
              requestEncoder: err.requestOptions.requestEncoder,
              responseDecoder: err.requestOptions.responseDecoder,
              listFormat: err.requestOptions.listFormat,
            ),
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            cancelToken: err.requestOptions.cancelToken,
            onReceiveProgress: err.requestOptions.onReceiveProgress,
            onSendProgress: err.requestOptions.onSendProgress,
          );

          return handler.resolve(retriedResponse);
        } else {
          localDataSource.clear();
          getIt<GlobalKey<NavigatorState>>().currentContext?.let((it) {
            SplashViewRoute().pushAndRemoveUntil(it, (route) => false);
          });
          handler.reject(DioException(
              error: "Logout", requestOptions: err.requestOptions));
        }
      } catch (e) {
        localDataSource.clear();
        getIt<GlobalKey<NavigatorState>>().currentContext?.let((it) {
          SplashViewRoute().pushAndRemoveUntil(it, (route) => false);
        });
        handler.reject(
            DioException(error: "Logout", requestOptions: err.requestOptions));
      }
    }
    super.onError(err, handler);
  }
}
