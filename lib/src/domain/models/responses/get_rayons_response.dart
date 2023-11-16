// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class GetRayonsResponse extends Equatable {
  final bool? success;
  final int? statusCode;
  final String? message;
  final RayonsList? data;

  const GetRayonsResponse({
    this.success,
    this.statusCode,
    this.message,
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

  factory GetRayonsResponse.fromMap(Map<String, dynamic> map) {
    return GetRayonsResponse(
      success: map['success'] != null ? map['success'] as bool : null,
      statusCode: map['statusCode'] != null ? map['statusCode'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      data: map['data'] != null
          ? RayonsList.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [success, statusCode, message, data];
}

class RayonsList extends Equatable {
  final List<Rayon>? rayons;

  const RayonsList({
    this.rayons,
  });

  RayonsList copyWith({
    List<Rayon>? rayons,
  }) {
    return RayonsList(
      rayons: rayons ?? this.rayons,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rayons': rayons?.map((x) => x.toMap()).toList(),
    };
  }

  factory RayonsList.fromMap(Map<String, dynamic> map) {
    return RayonsList(
      rayons: map['rayons'] != null
          ? (map['rayons'] as List<dynamic>)
              .map((i) => Rayon.fromMap(i))
              .toList()
          : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [rayons];
}

class Rayon extends Equatable {
  final int? rayonid;
  final String? rayonname;
  final int? categoryid;
  final int? companyid;

  const Rayon({
    this.rayonid,
    this.rayonname,
    this.categoryid,
    this.companyid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rayonid': rayonid,
      'rayonname': rayonname,
      'categoryid': categoryid,
      'companyid': companyid,
    };
  }

  factory Rayon.fromMap(Map<String, dynamic> map) {
    return Rayon(
      rayonid: map['rayonid'] != null ? map['rayonid'] as int : null,
      rayonname: map['rayonname'] != null ? map['rayonname'] as String : null,
      categoryid: map['categoryid'] != null ? map['categoryid'] as int : null,
      companyid: map['companyid'] != null ? map['companyid'] as int : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [rayonid, rayonname, categoryid, companyid];
}
