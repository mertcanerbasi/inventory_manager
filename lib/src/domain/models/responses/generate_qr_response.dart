import 'package:equatable/equatable.dart';

class QrModel extends Equatable {
  final String qrCodeLink;

  const QrModel({
    required this.qrCodeLink,
  });

  @override
  List<Object> get props => [qrCodeLink];

  factory QrModel.fromMap(Map<String, dynamic> map) {
    return QrModel(
      qrCodeLink: map['qrCodeLink'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qrCodeLink': qrCodeLink,
    };
  }

  @override
  bool get stringify => true;
}

class GenerateQrResponse extends Equatable {
  final bool success;
  final int statusCode;
  final String message;
  final QrModel? data;

  const GenerateQrResponse({
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

  factory GenerateQrResponse.fromMap(Map<String, dynamic> map) {
    return GenerateQrResponse(
      success: map['success'] as bool,
      statusCode: map['statusCode'] as int,
      message: map['message'] as String,
      data: map['data'] != null
          ? QrModel.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [success, statusCode, message, data];
}
