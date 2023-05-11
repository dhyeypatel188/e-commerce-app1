import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/controllers/product_controller.dart';
import 'package:shoping/services/firestore_services.dart';
import 'package:shoping/views/category_screen/items_detail.dart';
import 'package:shoping/widgets_common/bg_widget.dart';

import '../../widgets_common/loading_indicator.dart';

class categoriesDetails extends StatefulWidget {
  final String? title;
  final dynamic data;
  categoriesDetails({super.key, required this.title, this.data});

  @override
  State<categoriesDetails> createState() => _categoriesDetailsState();
}

class _categoriesDetailsState extends State<categoriesDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FireStoreServices.getSubCategoryProducts(title);
    } else {
      productMethod = FireStoreServices.getProduct(title);
    }
  }

  var controller = Get.find<Productcontroller>();

  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
          appBar: AppBar(
            title: widget.title!.text.fontFamily(bold).white.make(),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                    children: List.generate(
                        controller.subcat.length,
                        (index) => "${controller.subcat[index]}"
                                .text
                                .size(12)
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .makeCentered()
                                .box
                                .roundedSM
                                .white
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .size(120, 60)
                                .make()
                                .onTap(() {
                              switchCategory("${controller.subcat[index]}");
                              setState(() {});
                            }))),
              ),
              20.heightBox,
              StreamBuilder(
                  stream: productMethod,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        child: Center(
                          child: loadingIndicator(),
                        ),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Expanded(
                        child: "No products found!"
                            .text
                            .color(darkFontGrey)
                            .makeCentered(),
                      );
                    } else {
                      var data = snapshot.data!.docs;
                      return
                          //items container
                          Expanded(
                              child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 250,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 8),
                                  itemBuilder: (context, index) {
                                    return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Image.network(
                                            data[index]['p_img'][0],
                                            height: 150,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          "${data[index]['p_name']}"
                                              .text
                                              .fontFamily(semibold)
                                              .color(darkFontGrey)
                                              .make(),
                                          10.heightBox,
                                          "${data[index]['p_price']}"
                                              .numCurrency
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
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 4))
                                        .padding(const EdgeInsets.all(12))
                                        .make()
                                        .onTap(() {
                                      controller.checkIfFav(data[index]);

                                      Get.to(() => itemDetail(
                                          title: "${data[index]['p_name']}",
                                          data: data[index]));
                                    });
                                  }));
                    }
                  }),
            ],
          )),
    );
  }
}
