import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/auth_controller.dart';
import 'package:food_delivery_app/controller/cart_conroller.dart';
import 'package:food_delivery_app/database/database_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/route_helper.dart';
import 'package:food_delivery_app/utils/utils.dart';
import 'package:food_delivery_app/widgets/account_widget.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  var name = "";
  var mobile = "";
  var email = "";
  var address = "";
  var about = "";
  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            AppIcon(
              icon: Icons.person,
              iconColor: Colors.white,
              iconSize: 75,
              size: 150,
              bgColor: AppColors.mainColor,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Get.find<AuthController>().getUserLoggedIn() == true
                    ? Column(
                        children: [
                          AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.person,
                                iconSize: 20,
                                iconColor: Colors.white,
                                bgColor: AppColors.mainColor,
                              ),
                              bigText: BigText(text: name)),
                          AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.call,
                                iconSize: 20,
                                iconColor: Colors.white,
                                bgColor: Colors.amber,
                              ),
                              bigText: BigText(text: mobile)),
                          AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.email,
                                iconSize: 20,
                                iconColor: Colors.white,
                                bgColor: AppColors.mainColor,
                              ),
                              bigText: BigText(text: email)),
                          AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.location_on,
                                iconSize: 20,
                                iconColor: Colors.white,
                                bgColor: Colors.amber,
                              ),
                              bigText: BigText(text: address)),
                          AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.message,
                                iconSize: 20,
                                iconColor: Colors.white,
                                bgColor: AppColors.mainColor,
                              ),
                              bigText: BigText(text: "Spicy food lover")),
                          GestureDetector(
                            onTap: () {
                              _logoutUser();
                            },
                            child: AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.logout,
                                  iconSize: 20,
                                  iconColor: Colors.white,
                                  bgColor: Colors.red,
                                ),
                                bigText: BigText(text: "Logout")),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _loginUser();
                            },
                            child: AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.login,
                                  iconSize: 20,
                                  iconColor: Colors.white,
                                  bgColor: Colors.red,
                                ),
                                bigText: BigText(text: "Login")),
                          ),
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _getUserData() async {
    if (Get.find<AuthController>().getUserLoggedIn() == true) {
      var dbHelper = DatabaseHelper.instance;
      final allRows = await dbHelper.queryFirstRow();
      // print("===== ${allRows[DatabaseHelper.columnName]}");

      setState(() {
        name = "${allRows[DatabaseHelper.columnName]}";
        mobile = "${allRows[DatabaseHelper.columnMobile]}";
        email = "${allRows[DatabaseHelper.columnEmail]}";
        address = "${allRows[DatabaseHelper.columnAddress]}";
        about = "${allRows[DatabaseHelper.columnAbout]}";
      });
    }
  }

  Future<void> _loginUser() async {
    var data = await Get.toNamed(RouteHelper.getSignIn());
    print("==== $data");
    if (data == "success") {
      _getUserData();
    }
    setState(() {});
    // }
  }

  Future<void> _logoutUser() async {
    Get.find<AuthController>().clearLoggedInData();
    Get.find<CartController>().clearCartHistory();
    Utils.deleteFromDataBase();
    var data = await Get.toNamed(RouteHelper.getSignIn());
    print("==== $data");
    // if (data == "success") {
    setState(() {});
    // }
  }
}
