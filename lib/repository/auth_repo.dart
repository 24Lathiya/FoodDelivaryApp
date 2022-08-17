import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/models/sign_up_model.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> postSignUpData(SignUp signUp) async {
    // print("===body=== ${signUp.toJson()}"); // body (signUp) should be json
    return await apiClient.post(AppConstants.SIGN_UP_URI, signUp.toJson());
  }

  Future<Response> postSignInData(String phone, String password) async {
    return await apiClient
        .post(AppConstants.SIGN_IN_URI, {"phone": phone, "password": password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    setUserLoggedIn(true);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserPhoneAndPassword(String phone, String password) async {
    setUserLoggedIn(true);
    await sharedPreferences.setString(AppConstants.PHONE, phone);
    await sharedPreferences.setString(AppConstants.PASSWORD, password);
  }

  bool? getUserLoggedIn() {
    return sharedPreferences.getBool(AppConstants.LOGIN);
  }

  String? getUserPhone() {
    return sharedPreferences.getString(AppConstants.PHONE);
  }

  Future<void> setUserLoggedIn(bool isLogin) async {
    await sharedPreferences.setBool(AppConstants.LOGIN, isLogin);
  }

  Future<void> clearLoggedInData() async {
    apiClient.token = '';
    apiClient.updateHeader('');
    setUserLoggedIn(false);
    await sharedPreferences.setString(AppConstants.PHONE, '');
    await sharedPreferences.setString(AppConstants.PASSWORD, '');
  }
}
