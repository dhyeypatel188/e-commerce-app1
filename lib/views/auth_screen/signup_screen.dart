import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shoping/consts/colors.dart';
import 'package:shoping/consts/list.dart';
import 'package:shoping/consts/strings.dart';
import 'package:shoping/consts/styles.dart';
import 'package:shoping/views/auth_screen/login_screen.dart';
import 'package:shoping/widgets_common/applogo_widget.dart';
import 'package:shoping/widgets_common/bg_widget.dart';
import 'package:shoping/widgets_common/customTextField.dart';
import 'package:shoping/widgets_common/ourbutton.dart';
import 'package:velocity_x/velocity_x.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  bool? ischeck = false;
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
          "Join the to $appname".text.fontFamily(bold).white.size(18).make(),
          15.heightBox,
          Column(
            children: [
              customTextField(
                hint: namehint,
                title: name,
              ),
              customTextField(
                hint: emailhint,
                title: email,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: "or Register from a phone number".text.make(),
                  )),
              customTextField(
                hint: passwordhint,
                title: passwort,
              ),
              customTextField(
                hint: passwordhint,
                title: retypepass,
              ),

              5.heightBox,
              // ourButton().box.width(context.screenWidth - 50).make(),

              5.heightBox,
              Row(
                children: [
                  Checkbox(
                      activeColor: redColor,
                      checkColor: whiteColor,
                      value: ischeck,
                      onChanged: (newvalue) {
                        setState(() {
                          ischeck = newvalue;
                        });
                      }),
                  10.widthBox,
                  Expanded(
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: "I agree to the ",
                          style:
                              TextStyle(fontFamily: regular, color: fontGrey)),
                      TextSpan(
                          text: termsAndCond,
                          style:
                              TextStyle(fontFamily: regular, color: redColor)),
                      TextSpan(
                          text: " & ",
                          style:
                              TextStyle(fontFamily: regular, color: fontGrey)),
                      TextSpan(
                          text: privacypolicy,
                          style:
                              TextStyle(fontFamily: regular, color: redColor)),
                    ])),
                  ),
                ],
              ),

              ourButton(
                      color: ischeck == true ? redColor : lightGolden,
                      textcolor: ischeck == true ? whiteColor : golden,
                      onPress: () {},
                      title: signup)
                  .box
                  .width(context.screenWidth - 50)
                  .make(),
              10.heightBox,

              // warp into gesturedetection
              RichText(
                  text: const TextSpan(children: [
                TextSpan(
                    text: alreadyhaveaccount,
                    style: TextStyle(fontFamily: bold, color: fontGrey)),
                TextSpan(
                    text: login,
                    style: TextStyle(fontFamily: bold, color: redColor)),
              ])).onTap(() {
                Get.back();
              })
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
    ;
  }
}
