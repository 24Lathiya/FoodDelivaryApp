import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/auth_controller.dart';
import 'package:food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/utils.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mobileController = TextEditingController();
    var passwordController = TextEditingController();

    void _doLogin() {
      var authController = Get.find<AuthController>();
      var mobile = mobileController.text.trim();
      var password = passwordController.text.trim();

      if (mobile.isEmpty) {
        Utils.showCustomSnackBar("Mobile should not empty", title: "Mobile");
      } else if (!GetUtils.isPhoneNumber(mobile) && !GetUtils.isEmail(mobile)) {
        Utils.showCustomSnackBar("User name is not valid", title: "User name");
      } else if (password.isEmpty) {
        Utils.showCustomSnackBar("Password should not empty",
            title: "Password");
      } else if (password.length < 6) {
        Utils.showCustomSnackBar("Password length should not less then 6",
            title: "Password");
      } else {
        //auth
        // Utils.showCustomSnackBar("All Good", title: "Login", isError: false);

        authController.postSignInData(mobile, password);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: GetBuilder<AuthController>(builder: (authController) {
            return authController.isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(child: CircularProgressIndicator()))
                : Container(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 80.0,
                          backgroundImage:
                              AssetImage("assets/images/logo_part_1.png"),
                        ),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40.0),
                              ),
                              BigText(text: "Sign in to your account"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        AppTextField(
                          hintText: "Mobile/Email",
                          controller: mobileController,
                          icon: Icons.login,
                          textInputType: TextInputType.emailAddress,
                        ),
                        AppTextField(
                          hintText: "Password",
                          controller: passwordController,
                          icon: Icons.password,
                          isObscure: true,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () {
                            _doLogin();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: BigText(
                              text: "Sign In",
                              size: 25,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 30, right: 30),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                            SizedBox(
                              width: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "Create",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.off(SignUpPage(),
                                        transition: Transition.fade)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
