import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/controllers/cart_controller.dart';
import 'package:shoping/views/cart_screen/shipping_screen.dart';
import 'package:shoping/widgets_common/ourbutton.dart';

import '../../services/firestore_services.dart';
import '../../widgets_common/loading_indicator.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 50,
          child: ourButton(
              color: redColor,
              onPress: () {
                Get.to(() => const shippingDetail());
              },
              textcolor: whiteColor,
              title: "Proceed to shiping"),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shoping cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FireStoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                              '${data[index]['img']}',
                              width: 88,
                              fit: BoxFit.cover,
                            ),
                            title:
                                "${data[index]['title']} (x${data[index]['qty']})"
                                    .text
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                            subtitle: "${data[index]['tprice']}"
                                .numCurrency
                                .text
                                .size(14)
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            trailing: const Icon(
                              Icons.delete,
                              color: redColor,
                            ).onTap(() {
                              FireStoreServices.deleteDocument(data[index].id);
                            }),
                          );
                        },
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total price"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          Obx(
                            () => "${controller.totalP.value}"
                                .numCurrency
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                          )
                        ],
                      )
                          .box
                          .padding(EdgeInsets.all(12))
                          .color(lightGolden)
                          .width(context.screenWidth - 30)
                          .roundedSM
                          .make(),
                      10.heightBox,
                      // SizedBox(
                      //     width: context.screenWidth - 60,
                      //     child: ourButton(
                      //         color: redColor,
                      //         onPress: () {},
                      //         textcolor: whiteColor,
                      //         title: "Proceed to shiping"))
                    ],
                  ),
                );
              }
            }));
  }
}
