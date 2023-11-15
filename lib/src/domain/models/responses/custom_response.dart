import 'package:equatable/equatable.dart';

class CustomResponse extends Equatable {
  final bool success;
  final int statusCode;
  final String message;

  const CustomResponse({
    required this.success,
    required this.statusCode,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'statusCode': statusCode,
      'message': message,
    };
  }

  factory CustomResponse.fromMap(Map<String, dynamic> map) {
    return CustomResponse(
      success: map['success'] as bool,
      statusCode: map['statusCode'] as int,
      message: map['message'] as String,
    );
  }

  @override
  List<Object?> get props => [success, statusCode, message];
}
