import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/controllers/cart_controller.dart';
import 'package:shoping/views/cart_screen/payment_methods.dart';
import 'package:shoping/widgets_common/customTextField.dart';
import 'package:shoping/widgets_common/ourbutton.dart';

class shippingDetail extends StatelessWidget {
  const shippingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ourButton(
          onPress: () {
            if (controller.addressController.text.length > 10 &&
                controller.cityController.text.length > 0 &&
                controller.stateController.text.length > 0 &&
                controller.postalCodeController.text.length > 5 &&
                controller.phoneController.text.length >= 10) {
              Get.to(() => const PaymentMethods());
            } else {
              VxToast.show(context, msg: "Please fill the form");
            }
          },
          color: redColor,
          textcolor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          customTextField(
              hint: "Address",
              isPass: false,
              title: "Address",
              controller: controller.addressController),
          customTextField(
              hint: "City",
              isPass: false,
              title: "City",
              controller: controller.cityController),
          customTextField(
              hint: "State",
              isPass: false,
              title: "State",
              controller: controller.stateController),
          customTextField(
              hint: "Postal Code",
              isPass: false,
              title: "Postal Code",
              controller: controller.postalCodeController),
          customTextField(
              hint: "Phone Number",
              isPass: false,
              title: "Phone Number",
              controller: controller.phoneController),
        ]),
      ),
    );
  }
}
