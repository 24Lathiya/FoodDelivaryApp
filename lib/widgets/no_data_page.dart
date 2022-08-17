import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String image;
  const NoDataPage(
      {Key? key,
      required this.text,
      this.image = "assets/images/empty_cart.png"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
