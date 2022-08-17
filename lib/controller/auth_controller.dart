import 'dart:convert';

import 'package:food_delivery_app/models/responce_model.dart';
import 'package:food_delivery_app/models/sign_up_model.dart';
import 'package:food_delivery_app/repository/auth_repo.dart';
import 'package:food_delivery_app/utils/route_helper.dart';
import 'package:food_delivery_app/utils/utils.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});
  bool _isLoading = false;
  get isLoading => _isLoading;
  //Sign Up
  Future<ResponseModel> postSignUpData(SignUp signUp) async {
    _isLoading = true;
    update();
    Response response = await authRepo.postSignUpData(signUp);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("===RESPONCE=== ${response.body}");
      final result = json.decode(response.body);
      // print("===token===${result['token']}");
      if (result['status'] == "success") {
        authRepo.saveUserToken(result['token']);
        responseModel = ResponseModel(true, result['token']);
        Get.offNamed(RouteHelper.initial);
        // update();
        // Get.back(result: "success");
      } else {
        responseModel = ResponseModel(false, result['msg']);
      }
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    Future.delayed(const Duration(seconds: 2), () {
      _isLoading = false;
      update();
    });

    return responseModel;
  }

  //Sign In
  Future<void> postSignInData(String phone, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.postSignInData(phone, password);
    if (response.statusCode == 200) {
      print("===RESPONCE=== ${response.body}");
      var result = jsonDecode(response.body);
      // print("===status=== ${result['status']}");
      if (result['status'] == "success") {
        Utils.insertToDataBase(result['name'], "Male", result['mobile'],
            result['email'], "Surat Gujarat", "Spicy food lover");
        authRepo.saveUserPhoneAndPassword(phone, password);
        // update();
        Get.back(result: "success");
      } else {
        Utils.showCustomSnackBar("Check your username and password");
      }
    } else {
      Utils.showCustomSnackBar("Something went wrong");
    }
    Future.delayed(const Duration(seconds: 2), () {
      _isLoading = false;
      update();
    });
  }

  bool? getUserLoggedIn() {
    return authRepo.getUserLoggedIn();
  }

  String? getUserPhone() {
    return authRepo.getUserPhone();
  }

  clearLoggedInData() {
    authRepo.clearLoggedInData();
  }
}
