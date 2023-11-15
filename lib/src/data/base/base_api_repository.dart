import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import '../../utils/resources/data_state.dart';

/// The `BaseApiRepository` class is an abstract base class for API repositories.
/// It provides a method to retrieve the state of data from an HTTP request.
abstract class BaseApiRepository {
  /// Retrieves the state of data from an HTTP request.
  ///
  /// The `request` parameter is a function that makes the HTTP request and returns a `Future<HttpResponse<T>>`.
  /// It is expected to handle any necessary error handling and return an appropriate response.
  ///
  /// Returns a `Future<DataState<T>>` representing the state of the data.
  ///
  /// Throws a [DioException] if there is an error in the HTTP request.
  @protected
  Future<DataState<T>> getStateOf<T>(
      {required Future<HttpResponse<T>> Function() request}) async {
    try {
      final httpResponse = await request();

      // Check if the HTTP response status code is 200 (OK)
      if (httpResponse.response.statusCode == HttpStatus.ok ||
          httpResponse.response.statusCode == HttpStatus.created) {
        // Return a DataSuccess object with the retrieved data
        return DataSuccess(httpResponse.data!);
      } else {
        // Throw a DioException if the response status code is not 200
        throw DioException(
          requestOptions: httpResponse.response.requestOptions,
          response: httpResponse.response,
        );
      }
    }
    // Catch and handle any DioExceptions that occur during the HTTP request
    on DioException catch (e) {
      // Return a DataFailed object with the DioException as the error
      return DataFailed(e);
    }
  }
}
