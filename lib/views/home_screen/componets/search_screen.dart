import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/consts/colors.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/services/firestore_services.dart';
import 'package:shoping/widgets_common/loading_indicator.dart';

import '../../category_screen/items_detail.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No products found ".text.makeCentered();
          } else {
            var data = snapshot.data!.docs;

            var filtered = data
                .where((element) => element['p_name']
                    .toString()
                    .toLowerCase()
                    .contains(title!.toLowerCase()))
                .toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 250,
                ),
                children: filtered
                    .mapIndexed((currentValue, index) => Column(
                          children: [
                            Image.network(
                              filtered[index]['p_img'][0],
                              width: 200,
                              height: 180,
                              fit: BoxFit.contain,
                            ),
                            const Spacer(),
                            "${filtered[index]['p_name']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "${filtered[index]['p_price']}"
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(16)
                                .make()
                          ],
                        )
                            .box
                            .white
                            .roundedSM
                            .shadowSm
                            .padding(const EdgeInsets.all(12))
                            .make()
                            .onTap(() {
                          Get.to(() => itemDetail(
                                title: "${filtered[index]['p_name']}",
                                data: filtered[index],
                              ));
                        }))
                    .toList(),
              ),
            );
          }
        },
        future: FireStoreServices.searchProducts(title),
      ),
    );
  }
}
