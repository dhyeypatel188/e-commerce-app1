import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:shoping/consts/colors.dart';
import 'package:shoping/consts/images.dart';
import 'package:shoping/consts/strings.dart';
import 'package:shoping/consts/styles.dart';
import 'package:shoping/controllers/home_controller.dart';
import 'package:shoping/views/cart_screen/cart_screen.dart';
import 'package:shoping/views/category_screen/category_screen.dart';
import 'package:shoping/views/home_screen/home_screen.dart';
import 'package:shoping/views/profile_screen/profile_screen.dart';
import 'package:shoping/widgets_common/exit_dialog.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account),
    ];
    var navBody = [
      const HomeScreen(),
      const CategotyScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];
    return WillPopScope(
      onWillPop: () async {
        showDialog(context: context, builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbarItem,
            onTap: (Value) {
              controller.currentNavIndex.value = Value;
            },
          ),
        ),
      ),
    );
  }
}
