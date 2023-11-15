import '../models/responses/login_response.dart';

abstract class DatabaseRepository {
  UserData? get user;
  bool get isUserLoggedIn;
  Future setUser(UserData? user);
  Future setAccessToken(String accessToken);
  Future<void> clear();
}
