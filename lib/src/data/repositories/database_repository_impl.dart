import 'dart:convert';

import 'package:injectable/injectable.dart';
import '../../domain/models/responses/get_categories_response.dart';
import '../../domain/models/responses/get_rayons_response.dart';
import '../../domain/models/responses/login_response.dart';
import '../../domain/repositories/database_repository.dart';
import '../../utils/resources/encrypt_storage.dart';

@LazySingleton(as: DatabaseRepository)
@injectable
class DatabaseRepositoryImpl implements DatabaseRepository {
  final EncryptStorage _getStorage;
  DatabaseRepositoryImpl(this._getStorage);

  @override
  Future<void> clear() async {
    setUser(null);
    return;
  }

  @override
  Future setUser(UserData? user) {
    if (user != null) {
      return _getStorage.write("user", jsonEncode(user.toMap()));
    }
    return _getStorage.write("user", null);
  }

  @override
  UserData? get user {
    String? readData = _getStorage.read("user");
    if (readData != null) {
      Map<String, dynamic> json = jsonDecode(readData);
      return UserData.fromMap(json);
    }
    return null;
  }

  @override
  bool get isUserLoggedIn => user != null;

  @override
  Future setAccessToken(String accessToken) {
    UserData? tempUser = user;
    tempUser?.accessToken = accessToken;
    return _getStorage.write("user", jsonEncode(tempUser?.toMap()));
  }

  @override
  Future setCategories(List<Category> categories) {
    return _getStorage.write("categories", jsonEncode(categories));
  }

  @override
  Future setRayons(List<Rayon> rayons) {
    return _getStorage.write("rayons", jsonEncode(rayons));
  }

  @override
  List<Category>? getCategories() {
    String? readData = _getStorage.read("categories");
    if (readData != null) {
      List<dynamic> json = jsonDecode(readData);
      return List<Category>.from(json.map((x) => Category.fromMap(x)));
    }
    return null;
  }

  @override
  List<Rayon>? getRayons() {
    String? readData = _getStorage.read("rayons");
    if (readData != null) {
      List<dynamic> json = jsonDecode(readData);
      return List<Rayon>.from(json.map((x) => Rayon.fromMap(x)));
    }
    return null;
  }
}
