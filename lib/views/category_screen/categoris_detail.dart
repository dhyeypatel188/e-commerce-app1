import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/views/category_screen/items_detail.dart';
import 'package:shoping/widgets_common/bg_widget.dart';

class categoriesDetails extends StatelessWidget {
  String? title;
  categoriesDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                  children: List.generate(
                      6,
                      (index) => "Baby clothing"
                          .text
                          .size(12)
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .makeCentered()
                          .box
                          .roundedSM
                          .white
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .size(120, 60)
                          .make())),
            ),

            20.heightBox,
            //items container
            Expanded(
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 250,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Image.asset(
                              imgP5,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            "Laptop 4GB/64GB"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "\$600"
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(16)
                                .make(),
                          ])
                          .box
                          .white
                          .outerShadowSm
                          .roundedSM
                          .margin(const EdgeInsets.symmetric(horizontal: 4))
                          .padding(const EdgeInsets.all(12))
                          .make()
                          .onTap(() {
                        Get.to(() => itemDetail(title: "dummy  title"));
                      });
                    }))
          ]),
        ),
      ),
    );
  }
}
