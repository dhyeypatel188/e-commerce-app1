import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/controllers/profile_controller.dart';
import 'package:shoping/widgets_common/bg_widget.dart';
import 'package:shoping/widgets_common/customTextField.dart';
import 'package:shoping/widgets_common/ourbutton.dart';
import 'package:shoping/consts/strings.dart';
import '../../consts/images.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileConrtoller>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //if data image URL and controller path is empty
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()

                  //if data is not empty but controller path is empty
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()

                      //if both are empty
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ourButton(
                  color: redColor,
                  onPress: () {
                    controller.changeImage(context);
                  },
                  textcolor: whiteColor,
                  title: "Change"),
              const Divider(),
              20.heightBox,
              customTextField(
                  hint: namehint,
                  title: name,
                  isPass: false,
                  controller: controller.nameController),
              10.heightBox,
              customTextField(
                  hint: passwordhint,
                  title: oldpass,
                  isPass: true,
                  controller: controller.oldpassController),
              10.heightBox,
              customTextField(
                  hint: passwordhint,
                  title: newpass,
                  isPass: true,
                  controller: controller.newpassController),
              20.heightBox,
              controller.isloading.value
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                          color: redColor,
                          onPress: () async {
                            controller.isloading(true);

                            //if image is not selected
                            if (controller.profileImgPath.value.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImageLink = data['imageUrl'];
                            }

                            //if old password matches database

                            if (data['password'] ==
                                controller.oldpassController.text) {
                              await controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldpassController.text,
                                newpassword: controller.newpassController.text,
                              );

                              await controller.updateProfile(
                                  imgUrl: controller.profileImageLink,
                                  name: controller.nameController.text,
                                  password: controller.newpassController.text);
                              VxToast.show(context, msg: "Updated");
                            } else {
                              VxToast.show(context, msg: "Wrong old password");
                              controller.isloading(false);
                            }
                          },
                          textcolor: whiteColor,
                          title: "Save"),
                    ),
            ],
          )
              .box
              .white
              .padding(EdgeInsets.all(16))
              .shadowSm
              .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded
              .make(),
        ),
      ),
    ));
  }
}
