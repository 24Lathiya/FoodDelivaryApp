import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/recommended_product_controller.dart';
import 'package:food_delivery_app/models/person_model.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/route_helper.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_text_row.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PersonList extends StatefulWidget {
  // final List<Results> results;
  const PersonList({Key? key}) : super(key: key);

  @override
  State<PersonList> createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isDataLoaded = false;
  int currentPage = 1;
  late int totalPages;
  List<Results> results = [];
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  Future<bool> getPersonData({bool isRefresh = false}) async {
    // print("===api calling=== $isRefresh");
    if (isRefresh) {
      currentPage = 1;
      isDataLoaded = false;
      refreshController.resetNoData();
      // print("===isDataLoaded=== $isDataLoaded $currentPage");
    } else {
      if (currentPage >= totalPages) {
        // print("===load no data===");
        isDataLoaded = true;
        return false;
      }
    }

    /*final Uri uri = Uri.parse("https://randomuser.me/api/1.4?results=10");

    final response = await get(uri);
    //   print(response.body);
    if (response.statusCode == 200) {
      final person = Persons.fromJson(jsonDecode(response.body));*/

    await Get.find<RecommendedProductController>().getRecommendedProductList();
    var tempResult =
        Get.find<RecommendedProductController>().recommendedProductList;
    print("===tempResult=== ${tempResult.length}");
    if (tempResult.isNotEmpty) {
      if (isRefresh) {
        // results = person.results!;
        results = tempResult;
        isRefresh = false;
      } else {
        // results.addAll(person.results!);
        results = []; // fix _GrowableList error
        results.addAll(tempResult);
      }
      currentPage++;
      totalPages = 3;
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          Get.find<RecommendedProductController>()
              .clearRecommendedProductList();
          final result = await getPersonData(isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await getPersonData();
          // print("===isDataLoaded=== $isDataLoaded");
          if (result) {
            refreshController.loadComplete();
          } else if (isDataLoaded) {
            refreshController.loadNoData();
          } else {
            refreshController.loadFailed();
          }
        },
        /*footer: CustomFooter(builder: (context, mode) {
          Widget body ;
          if(mode==LoadStatus.idle){
            body =  Text("pull up load");
          }
          else if(mode==LoadStatus.loading){
            body =  CupertinoActivityIndicator();
          }
          else if(mode == LoadStatus.failed){
            body = Text("Load Failed!Click retry!");
          }
          else if(mode == LoadStatus.canLoading){
            body = Text("release to load more");
          }
          else{
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child:body),
          );
        }),*/
        child: ListView.builder(
          padding: EdgeInsets.all(12),
          // physics: NeverScrollableScrollPhysics(),
          // to scroll all page
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Get.to(() => RecommendedFoodDetailPage(index: index,)); // disable back button in next screen
                // Get.toNamed(RouteHelper.recommendedFood);
                Get.toNamed(RouteHelper.getRecommendedFood(index, "home"));
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        // image: Image.asset("assets/images/${imageList[index]}")
                        image: DecorationImage(
                            image: NetworkImage(
                                "${results[index].picture!.large}")),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 120,
                      width: 120,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
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
                                  "${results[index].name!.title} ${results[index].name!.first} ${results[index].name!.last}",
                              color: AppColors.mainBlackColor,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SmallText(
                                text: "${results[index].location!.country}"),
                            const SizedBox(
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
              ),
            );
          },
          itemCount: results.length,
        ),
      ),
    );
  }
}
