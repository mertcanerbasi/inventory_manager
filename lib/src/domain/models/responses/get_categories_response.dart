// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class GetCategoriesResponse extends Equatable {
  final bool? success;
  final int? statusCode;
  final String? message;
  final CategoryList? data;

  const GetCategoriesResponse({
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

  factory GetCategoriesResponse.fromMap(Map<String, dynamic> map) {
    return GetCategoriesResponse(
      success: map['success'] != null ? map['success'] as bool : null,
      statusCode: map['statusCode'] != null ? map['statusCode'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      data: map['data'] != null
          ? CategoryList.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [success, statusCode, message, data];
}

class CategoryList extends Equatable {
  final List<Category>? categories;

  const CategoryList({
    this.categories,
  });

  CategoryList copyWith({
    List<Category>? categories,
  }) {
    return CategoryList(
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categories': categories?.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoryList.fromMap(Map<String, dynamic> map) {
    return CategoryList(
      categories: map['categories'] != null
          ? List<Category>.from(
              (map['categories'] as List<dynamic>).map<Category?>(
                (x) => Category.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [categories];
}

class Category extends Equatable {
  final int? categoryid;
  final String? categoryname;
  final int? companyid;

  const Category({
    this.categoryid,
    this.categoryname,
    this.companyid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryid': categoryid,
      'categoryname': categoryname,
      'companyid': companyid,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      categoryid: map['categoryid'] != null ? map['categoryid'] as int : null,
      categoryname:
          map['categoryname'] != null ? map['categoryname'] as String : null,
      companyid: map['companyid'] != null ? map['companyid'] as int : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [categoryid, categoryname, companyid];
}
