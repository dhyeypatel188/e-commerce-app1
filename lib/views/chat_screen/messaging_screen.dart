import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/services/firestore_services.dart';
import 'package:shoping/views/chat_screen/chat_screen.dart';
import 'package:shoping/widgets_common/loading_indicator.dart';

// ignore: camel_case_types
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          backgroundColor: whiteColor,
          title: "My Messagies"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make()),
      body: StreamBuilder(
          stream: FireStoreServices.getAllMessages(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Messagies yet!"
                  .text
                  .color(darkFontGrey)
                  .makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Get.to(() => ChatScreen(), arguments: [
                                data[index]['friend_name'],
                                data[index]['toId'],
                              ]);
                            },
                            leading: CircleAvatar(
                                backgroundColor: redColor,
                                child: Icon(
                                  Icons.person,
                                  color: whiteColor,
                                )),
                            title: "${data[index]['friend_name']}"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make(),
                            subtitle: "${data[index]['last_msg']}".text.make(),
                          ),
                        );
                      },
                      itemCount: data.length,
                    ))
                  ],
                ),
              );
            }
          }),
    );
  }
}
