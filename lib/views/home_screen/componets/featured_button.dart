import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/views/category_screen/categoris_detail.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).size(10).make()
    ],
  )
      .box
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .roundedSM
      .padding(EdgeInsets.all(4))
      .outerShadowSm
      .make()
      .onTap(() {
    Get.to(() => categoriesDetails(title: title));
  });
}
