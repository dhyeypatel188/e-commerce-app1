import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/services/firestore_services.dart';
import 'package:shoping/views/orders_screen/orders_details.dart';
import 'package:shoping/widgets_common/loading_indicator.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          backgroundColor: whiteColor,
          title:
              "My Orders".text.color(darkFontGrey).fontFamily(semibold).make()),
      body: StreamBuilder(
          stream: FireStoreServices.getAllOrders(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No orders yet!".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: "${index + 1}"
                        .text
                        .fontFamily(bold)
                        .color(darkFontGrey)
                        .xl
                        .make(),
                    tileColor: lightGrey,
                    title: data[index]['order_code']
                        .toString()
                        .text
                        .fontFamily(semibold)
                        .color(redColor)
                        .make(),
                    subtitle: data[index]['total_amount']
                        .toString()
                        .numCurrency
                        .text
                        .fontFamily(semibold)
                        .make(),
                    trailing: IconButton(
                        onPressed: () {
                          Get.to(() => OrdersDetails(data: data[index]));
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: darkFontGrey,
                        )),
                  );
                },
              );
            }
          }),
    );
  }
}
