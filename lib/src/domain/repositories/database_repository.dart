import '../models/responses/get_categories_response.dart';
import '../models/responses/get_rayons_response.dart';
import '../models/responses/login_response.dart';

abstract class DatabaseRepository {
  UserData? get user;
  bool get isUserLoggedIn;
  Future setUser(UserData? user);
  Future setAccessToken(String accessToken);
  Future<void> clear();
  Future setCategories(List<Category> categories);
  List<Category>? getCategories();
  Future setRayons(List<Rayon> rayons);
  List<Rayon>? getRayons();
}
