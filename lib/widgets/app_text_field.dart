import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  bool isObscure;
  TextInputType textInputType;
  AppTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.icon,
      this.textInputType = TextInputType.text,
      this.isObscure = false})
      : super(key: key);

  /*final _formKey = GlobalKey<FormState>();

  validateFields() {
    if (_formKey.currentState!.validate()) {

    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 3,
                    spreadRadius: 1,
                    offset: Offset(0, 1))
              ],
            ),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: Icon(
                  icon,
                  color: AppColors.mainColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(width: 1.0, color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(width: 1.0, color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              obscureText: isObscure,
              keyboardType: textInputType,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return "field should not empty";
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
