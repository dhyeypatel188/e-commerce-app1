import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/services/firestore_services.dart';
import 'package:shoping/widgets_common/loading_indicator.dart';

// ignore: camel_case_types
class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          backgroundColor: whiteColor,
          title: "My Wishlist"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make()),
      body: StreamBuilder(
          stream: FireStoreServices.getWishlist(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Wishlist yet!".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                              '${data[index]['p_img'][0]}',
                              width: 88,
                              fit: BoxFit.cover,
                            ),
                            title: "${data[index]['p_name']}"
                                .text
                                .fontFamily(semibold)
                                .size(16)
                                .make(),
                            subtitle: "${data[index]['p_price']}"
                                .numCurrency
                                .text
                                .size(14)
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            trailing: const Icon(
                              Icons.favorite,
                              color: redColor,
                            ).onTap(() async {
                              await firestore
                                  .collection(productsCollection)
                                  .doc(data[index].id)
                                  .set({
                                'p_wishlist':
                                    FieldValue.arrayRemove([currentUser!.uid])
                              }, SetOptions(merge: true));
                            }),
                          );
                        }),
                  ),
                ],
              );
            }
          }),
    );
  }
}
