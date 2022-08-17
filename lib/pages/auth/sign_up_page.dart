import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/auth_controller.dart';
import 'package:food_delivery_app/database/database_helper.dart';
import 'package:food_delivery_app/models/sign_up_model.dart';
import 'package:food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/utils.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper.instance;

    var nameController = TextEditingController();
    var mobileController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _doRegistration() {
      var authController = Get.find<AuthController>();
      var name = nameController.text.trim();
      var mobile = mobileController.text.trim();
      var email = emailController.text.trim();
      var password = passwordController.text.trim();

      if (name.isEmpty) {
        Utils.showCustomSnackBar("Name should not empty", title: "Name");
      } else if (mobile.isEmpty) {
        Utils.showCustomSnackBar("Mobile should not empty", title: "Mobile");
      } else if (!GetUtils.isPhoneNumber(mobile)) {
        Utils.showCustomSnackBar("Mobile is not valid", title: "Mobile");
      } else if (email.isEmpty) {
        Utils.showCustomSnackBar("Email should not empty", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        Utils.showCustomSnackBar("Email is not valid", title: "Email");
      } else if (password.isEmpty) {
        Utils.showCustomSnackBar("Password should not empty",
            title: "Password");
      } else if (password.length < 6) {
        Utils.showCustomSnackBar("Password length should not less then 6",
            title: "Password");
      } else {
        //auth
        // Utils.showCustomSnackBar("All Good", title: "Auth", isError: false);

        SignUp signUp = SignUp(
            name: name, mobile: mobile, email: email, password: password);
        authController.postSignUpData(signUp).then((status) {
          if (status.isSuccess) {
            Utils.showCustomSnackBar("Sign Up Successfully",
                title: "Sign Up", isError: false);
            Utils.insertToDataBase(name, "Male", mobile, email, "Surat Gujarat",
                "Spicy food lover");
          } else {
            Utils.showCustomSnackBar("Something went wrong");
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: GetBuilder<AuthController>(builder: (authController) {
            // print("====== ${authController.isLoading}");
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
                        AppTextField(
                          hintText: "Name",
                          controller: nameController,
                          icon: Icons.person,
                        ),
                        AppTextField(
                          hintText: "Mobile",
                          controller: mobileController,
                          icon: Icons.phone,
                          textInputType: TextInputType.phone,
                        ),
                        AppTextField(
                          hintText: "Email",
                          controller: emailController,
                          icon: Icons.email,
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
                            _doRegistration();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: BigText(
                              text: "Sign Up",
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
                            Text("Have an account?",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                            SizedBox(
                              width: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "Sign In",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.off(SignInPage(),
                                        transition: Transition.fade)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SmallText(text: "Sign Up using one of the method"),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/g.png"),
                                radius: 25,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/f.png"),
                                radius: 25,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/t.png"),
                                radius: 25,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
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
