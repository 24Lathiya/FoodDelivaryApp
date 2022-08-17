import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/recommended_product_controller.dart';
import 'package:food_delivery_app/models/person_model.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_text_row.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key? key}) : super(key: key);

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecommendedProductController>(
        builder: (recommendedProducts) {
          return ListView.builder(
            padding: EdgeInsets.all(12),
            physics: NeverScrollableScrollPhysics(),
            // to scroll all page
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Results results =
              recommendedProducts.recommendedProductList[index];
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        // image: Image.asset("assets/images/${imageList[index]}")
                        image: DecorationImage(
                            image: NetworkImage("${results.picture!.large}")),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 120,
                      width: 120,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text:
                              "${results.name!.title} ${results.name!.first} ${results.name!.last}",
                              color: AppColors.mainBlackColor,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SmallText(
                                text:
                                "${results.location!.country}"),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconTextRow(
                                    icon: Icons.circle_sharp,
                                    color: AppColors.iconColor1,
                                    text: "Normal"),
                                IconTextRow(
                                    icon: Icons.place,
                                    color: AppColors.mainColor,
                                    text: "12km"),
                                IconTextRow(
                                    icon: Icons.access_time_rounded,
                                    color: AppColors.iconColor2,
                                    text: "30min")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            itemCount: recommendedProducts.recommendedProductList.length,
          );
        });
  }
}
