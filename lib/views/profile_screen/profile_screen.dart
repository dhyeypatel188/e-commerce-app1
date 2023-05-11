import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/consts/list.dart';
import 'package:shoping/controllers/authcontroller.dart';
import 'package:shoping/controllers/profile_controller.dart';
import 'package:shoping/services/firestore_services.dart';
import 'package:shoping/views/auth_screen/login_screen.dart';
import 'package:shoping/views/chat_screen/messaging_screen.dart';
import 'package:shoping/views/orders_screen/orders_screen.dart';
import 'package:shoping/views/profile_screen/copmonents/details_button.dart';
import 'package:shoping/views/profile_screen/edit_profileScreen.dart';
import 'package:shoping/views/wishlist_screen/whishlist_screen.dart';
import 'package:shoping/widgets_common/bg_widget.dart';
import 'package:shoping/widgets_common/loading_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileConrtoller());
    FireStoreServices.getCount();
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: FireStoreServices.getUser(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          );
        } else {
          var data = snapshot.data!.docs[0];
          return Column(
            children: [
              30.heightBox,

              //edit profile button
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.edit,
                      color: whiteColor,
                    )).onTap(() {
                  controller.nameController.text = data['name'];
                  Get.to(() => EditProfileScreen(
                        data: data,
                      ));
                }),
              ),
              //users details section
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  children: [
                    data['imageUrl'] == ''
                        ? Image.asset(
                            imgProfile2,
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.network(
                            data['imageUrl'],
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                    10.widthBox,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "${data['name']}"
                            .text
                            .fontFamily(semibold)
                            .white
                            .make(),
                        5.heightBox,
                        "${data['email']}".text.white.make(),
                      ],
                    )),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                          color: whiteColor,
                        )),
                        onPressed: () async {
                          await Get.put(AuthController())
                              .signoutMethod(context);
                          Get.offAll(() => const LoginScreen());
                        },
                        child: "Logout".text.fontFamily(semibold).white.make())
                  ],
                ),
              ),
              // 20.heightBox,

              FutureBuilder(
                  future: FireStoreServices.getCount(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: loadingIndicator());
                    } else {
                      var CountData = snapshot.data;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detailsCard(
                              count: CountData[0].toString(),
                              title: "in your cart",
                              width: context.screenWidth / 3.4),
                          detailsCard(
                              count: CountData[1].toString(),
                              title: "in your wishlist",
                              width: context.screenWidth / 3.4),
                          detailsCard(
                              count: CountData[2].toString(),
                              title: "your orders",
                              width: context.screenWidth / 3.4)
                        ],
                      );
                    }
                  }),
              // 20.heightBox,
              //buttons section
              ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: lightGrey,
                        );
                      },
                      itemCount: profileButtonList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const OrderScreen());
                                break;
                              case 1:
                                Get.to(() => const WishListScreen());
                                break;
                              case 2:
                                Get.to(() => const MessagesScreen());
                                break;
                            }
                          },
                          leading: Image.asset(
                            profileButtonIcon[index],
                            width: 22,
                          ),
                          title: "${profileButtonList[index]}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                        );
                      })
                  .box
                  .white
                  .roundedSM
                  .padding(EdgeInsets.symmetric(horizontal: 16))
                  .margin(EdgeInsets.all(12))
                  .shadowSm
                  .make()
                  .box
                  .color(redColor)
                  .make()
            ],
          );
        }
      },
    )));
  }
}
