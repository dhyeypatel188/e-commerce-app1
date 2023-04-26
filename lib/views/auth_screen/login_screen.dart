import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/consts/list.dart';
import 'package:shoping/views/auth_screen/signup_screen.dart';
import 'package:shoping/views/home_screen/home.dart';
import 'package:shoping/widgets_common/applogo_widget.dart';
import 'package:shoping/widgets_common/bg_widget.dart';
import 'package:shoping/widgets_common/customTextField.dart';
import 'package:shoping/widgets_common/ourbutton.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
          15.heightBox,
          Column(
            children: [
              customTextField(
                hint: emailhint,
                title: email,
              ),
              customTextField(
                hint: passwordhint,
                title: passwort,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: forgetpass.text.make(),
                  )),
              5.heightBox,
              // ourButton().box.width(context.screenWidth - 50).make(),
              ourButton(
                      color: redColor,
                      textcolor: whiteColor,
                      onPress: () {
                        Get.to(() => Home());
                      },
                      title: login)
                  .box
                  .width(context.screenWidth - 50)
                  .make(),
              5.heightBox,
              createnewacco.text.color(fontGrey).make(),
              5.heightBox,
              ourButton(
                      color: lightGolden,
                      textcolor: redColor,
                      onPress: () {
                        Get.to(() => const Signup());
                      },
                      title: signup)
                  .box
                  .width(context.screenWidth - 50)
                  .make(),
              10.heightBox,
              loginWith.text.color(fontGrey).make(),
              15.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    3,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child:
                                Image.asset(socialIconList[index], width: 30),
                          ),
                        )),
              ),
            ],
          )
              .box
              .white
              .rounded
              .padding(const EdgeInsets.all(16))
              .width(context.screenWidth - 60)
              .shadowSm
              .make(),
        ],
      )),
    ));
  }
}
