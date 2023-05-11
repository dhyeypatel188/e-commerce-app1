import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/consts/list.dart';
import 'package:shoping/controllers/product_controller.dart';
import 'package:shoping/views/category_screen/categoris_detail.dart';
import 'package:shoping/widgets_common/bg_widget.dart';

class CategotyScreen extends StatelessWidget {
  const CategotyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Productcontroller());
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    cetegoryimg[index],
                    height: 120,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  10.heightBox,
                  "${cetegorylist[index]}"
                      .text
                      .color(darkFontGrey)
                      .align(TextAlign.center)
                      .make()
                ],
              )
                  .box
                  .white
                  .roundedSM
                  .outerShadowSm
                  .clip(Clip.antiAlias)
                  .make()
                  .onTap(() {
                controller.getSubcategories(cetegorylist[index]);
                Get.to(() => categoriesDetails(title: cetegorylist[index]));
              });
            }),
      ),
    ));
  }
}
