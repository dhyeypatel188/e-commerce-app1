import 'package:flutter/material.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/consts/list.dart';
import 'package:shoping/views/profile_screen/copmonents/details_button.dart';
import 'package:shoping/widgets_common/bg_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        body: Column(
          children: [
            30.heightBox,

            //edit profile button
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.edit,
                    color: whiteColor,
                  )).onTap(() {}),
            ),
            //users details section
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Image.asset(
                    imgProfile2,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                  10.widthBox,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Dummy user".text.fontFamily(semibold).white.make(),
                      5.heightBox,
                      "customer@gmaill.com".text.white.make(),
                    ],
                  )),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                        color: whiteColor,
                      )),
                      onPressed: () {},
                      child: "Logout".text.fontFamily(semibold).white.make())
                ],
              ),
            ),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                detailsCard(
                    count: "00",
                    title: "in your cart",
                    width: context.screenWidth / 3.4),
                detailsCard(
                    count: "22",
                    title: "in your wishlist",
                    width: context.screenWidth / 3.4),
                detailsCard(
                    count: "140",
                    title: "your orders",
                    width: context.screenWidth / 3.4)
              ],
            ),
            20.heightBox,
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
        ),
      ),
    );
  }
}
