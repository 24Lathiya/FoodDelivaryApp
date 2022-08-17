import 'package:flutter/material.dart';
import 'package:food_delivery_app/database/database_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utils {
  static double getRoundDouble(double value) =>
      double.parse(value.toStringAsFixed(2));
  // static formatDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

  static formatDate(String time) {
    DateTime dateTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse(time);
    return DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);
  }

  static showCustomSnackBar(
    String message, {
    String title = "Error",
    bool isError = true,
  }) {
    Get.snackbar(
      title,
      message,
      titleText: BigText(
        text: title,
        color: Colors.white,
      ),
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? Colors.redAccent : AppColors.mainColor,
    );
  }

  static Future<void> insertToDataBase(String name, String gender,
      String mobile, String email, String address, String about) async {
    final dbHelper = DatabaseHelper.instance;
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnGender: gender,
      DatabaseHelper.columnMobile: mobile,
      DatabaseHelper.columnEmail: email,
      DatabaseHelper.columnAddress: address,
      DatabaseHelper.columnAbout: about,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    //  getData(dbHelper);
  }

  static Future<void> deleteFromDataBase() async {
    final dbHelper = DatabaseHelper.instance;
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((element) {
      dbHelper.delete(element[DatabaseHelper.columnId]);
    });
    //  getData(dbHelper);
  }

  // static Future<void> getData(DatabaseHelper dbHelper) async {
  //   final allRows = await dbHelper.queryAllRows();
  //   print('query all rows:');
  //   allRows.forEach(print);
  // }
}
