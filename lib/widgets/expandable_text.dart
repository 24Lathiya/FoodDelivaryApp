import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class ExpandableText extends StatefulWidget {
  String text;
  ExpandableText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  var textHeight = Dimentions.screenHeight / 5.6;
  var isExpanded = false;

  @override
  void initState() {
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(text: firstHalf)
          : Column(
              children: [
                SmallText(
                    text: isExpanded
                        ? (firstHalf + secondHalf)
                        : "$firstHalf..."),
                InkWell(
                  child: secondHalf.isEmpty
                      ? Container()
                      : Row(
                          children: [
                            SmallText(
                              text: isExpanded ? "Show Less" : "Show More",
                              color: AppColors.mainColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon( isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                              color: AppColors.mainColor,
                            ),
                          ],
                        ),
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                )
              ],
            ),
    );
  }
}
