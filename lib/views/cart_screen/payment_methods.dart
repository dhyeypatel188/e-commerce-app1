import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/consts/list.dart';
import 'package:shoping/controllers/cart_controller.dart';
import 'package:shoping/widgets_common/loading_indicator.dart';

import '../../widgets_common/ourbutton.dart';
import '../home_screen/home.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 50,
          child: controller.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ourButton(
                  onPress: () async {
                    controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);

                    await controller.clearCart();
                    VxToast.show(context, msg: "Order placed successfully");
                    Get.offAll(const Home());
                  },
                  color: redColor,
                  textcolor: whiteColor,
                  title: "Place my order",
                ),
        ),
        appBar: AppBar(
          backgroundColor: whiteColor,
          title: "Choose Payment method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
                children: List.generate(paymentMethodImg.length, (index) {
              return GestureDetector(
                onTap: () {
                  controller.changePaymentIndex(index);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: controller.paymentIndex.value == index
                            ? redColor
                            : whiteColor,
                        width: 3,
                      )),
                  margin: EdgeInsets.only(bottom: 12),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        paymentMethodImg[index],
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.3)
                            : Colors.transparent,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                activeColor: Colors.green,
                                value: true,
                                onChanged: (value) {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            )
                          : Container(),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: controller.paymentIndex.value == index
                            ? paymentMethods[index]
                                .text
                                .white
                                .fontFamily(semibold)
                                .size(16)
                                .make()
                            : paymentMethods[index]
                                .text
                                .transparent
                                .fontFamily(semibold)
                                .size(16)
                                .make(),
                      )
                    ],
                  ),
                ),
              );
            })),
          ),
        ),
      ),
    );
  }
}
