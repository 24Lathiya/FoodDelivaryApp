import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/auth_controller.dart';
import 'package:food_delivery_app/controller/cart_conroller.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/controller/recommended_product_controller.dart';
import 'package:food_delivery_app/order/payment_option_button.dart';
import 'package:food_delivery_app/order/payment_type_radio.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/route_helper.dart';
import 'package:food_delivery_app/utils/utils.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/no_data_page.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  // final String page;
  const CartPage({
    Key? key,
    /*required this.page*/
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var isOnlinePayment;
  var totalAmount;

  /*late var _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("===success=== $response");
    Utils.showCustomSnackBar("Payment Success",
        title: "Payment", isError: false);
    Get.find<CartController>().addToHistory();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("===fail=== $response");
    Utils.showCustomSnackBar("Payment fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("===wallet=== $response");
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    var noteController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 45,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    bgColor: AppColors.mainColor,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(
                  width: 100,
                ),
                InkWell(
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    bgColor: AppColors.mainColor,
                  ),
                  onTap: () {
                    Get.toNamed(RouteHelper.initial);
                  },
                ),
                GetBuilder<CartController>(builder: (cartController) {
                  return Stack(
                    children: [
                      AppIcon(
                        icon: Icons.shopping_cart,
                        iconColor: Colors.white,
                        bgColor: AppColors.mainColor,
                      ),
                      cartController.totalQuantity > 0
                          ? Positioned(
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Text(
                                  "${cartController.totalQuantity}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                padding: const EdgeInsets.all(5.0),
                              ),
                              right: 0,
                              top: 0,
                            )
                          : Container(),
                    ],
                  );
                }),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (cartController) {
            return cartController.getCartList().isNotEmpty
                ? Positioned(
                    top: 100,
                    left: 20,
                    right: 20,
                    bottom: 0,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child:
                          GetBuilder<CartController>(builder: (cartController) {
                        return ListView.builder(
                            itemCount: cartController.totalItems.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  var popularIndex =
                                      Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(cartController
                                              .totalItems[index].results!);
                                  if (popularIndex >= 0) {
                                    print("popularIndex $popularIndex");
                                    Get.toNamed(RouteHelper.getPopularFood(
                                        popularIndex, "cart"));
                                  } else {
                                    var recommendedIndex =
                                        Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(cartController
                                                .totalItems[index].results!);
                                    print("recommendedIndex $recommendedIndex");
                                    if (recommendedIndex >= 0) {
                                      Get.toNamed(
                                          RouteHelper.getRecommendedFood(
                                              recommendedIndex, "cart"));
                                    } else {
                                      Get.snackbar("History Item",
                                          "Preview is not available",
                                          backgroundColor: AppColors.mainColor,
                                          colorText: Colors.white);
                                    }
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(cartController
                                                .totalItems[index].image!),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              BigText(
                                                  text: cartController
                                                      .totalItems[index].name!),
                                              SmallText(text: "Spice"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text:
                                                        "\S ${Utils.getRoundDouble(cartController.totalItems[index].price! * cartController.totalItems[index].quantity!)}",
                                                    color: Colors.red,
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        InkWell(
                                                          child: const Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                          onTap: () {
                                                            cartController.addItem(
                                                                cartController
                                                                    .totalItems[
                                                                        index]
                                                                    .results!,
                                                                -1);
                                                          },
                                                        ),
                                                        BigText(
                                                            text:
                                                                "${cartController.totalItems[index].quantity!}"),
                                                        InkWell(
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                          onTap: () {
                                                            cartController.addItem(
                                                                cartController
                                                                    .totalItems[
                                                                        index]
                                                                    .results!,
                                                                1);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                    ),
                  )
                : const NoDataPage(text: "Cart is Empty");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          noteController.text = cartController.foodNote;
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: AppColors.buttonBackgroundColor,
            ),
            child: cartController.getCartList().isNotEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext buildContex) {
                                return SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        const PaymentOptionButton(
                                          index: 0,
                                          icon: Icons.money,
                                          title: "Cash On Delivery",
                                          subTitle:
                                              "Pay your payment after getting food",
                                        ),
                                        const PaymentOptionButton(
                                          index: 1,
                                          icon: Icons.paypal,
                                          title: "Digital Payment",
                                          subTitle:
                                              "Faster and safer way to pay money",
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: BigText(text: "Delivery Type"),
                                        ),
                                        const PaymentTypeRadio(
                                            index: 0,
                                            title: "Home Delivery (20)"),
                                        const PaymentTypeRadio(
                                            index: 1,
                                            title: "Take Away (Free)"),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: BigText(
                                              text: "Additional Information"),
                                        ),
                                        AppTextField(
                                          hintText: "Enter Note",
                                          controller: noteController,
                                          icon: Icons.note,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).whenComplete(() {
                            print("====on close bottom sheet====");
                            print(
                                "additional: ${noteController.text} \t delivery option: ${cartController.paymentIndex} \t delivery type: ${cartController.paymentTypeIndex}");
                            cartController.setFoodNote(noteController.text
                                .trim()); // trim remove extra spaces
                            isOnlinePayment = cartController.paymentIndex == 1;
                            var tempAmount =
                                Utils.getRoundDouble(cartController.totalPrice);
                            totalAmount = cartController.paymentTypeIndex == 0
                                ? tempAmount + 20
                                : tempAmount;
                            print(
                                "===total=== $totalAmount ===isonline=== $isOnlinePayment");
                          });
                        },
                        child: Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: AppColors.mainColor),
                          child: Center(
                            child: BigText(
                              text: "Payment Options",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.white,
                              ),
                              child: BigText(
                                text:
                                    "\$ ${Utils.getRoundDouble(cartController.totalPrice)}",
                              )),
                          GestureDetector(
                            onTap: () {
                              if (Get.find<AuthController>()
                                      .getUserLoggedIn() ==
                                  true) {
                                if (isOnlinePayment) {
                                  print(
                                      "===amount=== $totalAmount === ${Get.find<AuthController>().getUserPhone()}");
                                  // var options = {
                                  //   'key': 'rzp_test_g6ggnb0Dw7RNtc',
                                  //   'amount': '${totalAmount * 100}',
                                  //   'name': 'Acme Corp.',
                                  //   'description': 'Fine T-Shirt',
                                  //   'prefill': {
                                  //     'contact': '8888888888',
                                  //     'email': 'test@razorpay.com'
                                  //   }
                                  // };
                                  // _razorpay.open(options);
                                } else {
                                  cartController.addToHistory();
                                }
                              } else {
                                Get.toNamed(RouteHelper.getSignUp());
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: AppColors.mainColor,
                              ),
                              child: BigText(
                                text: "Check Out",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(
                    height: 100,
                  ),
          );
        },
      ),
    );
  }
}
