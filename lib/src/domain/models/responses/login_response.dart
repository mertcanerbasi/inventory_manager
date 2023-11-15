// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  String accessToken;
  String refreshToken;
  int company;

  UserData({
    required this.accessToken,
    required this.refreshToken,
    required this.company,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'company': company,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      company: map['company'] as int,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [accessToken, refreshToken, company];
}

class LoginResponse extends Equatable {
  final bool success;
  final int statusCode;
  final String message;
  final UserData? data;

  const LoginResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      success: map['success'] as bool,
      statusCode: map['statusCode'] as int,
      message: map['message'] as String,
      data: map['data'] != null
          ? UserData.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  List<Object?> get props => [success, statusCode, message, data];
}
