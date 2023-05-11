import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping/consts/colors.dart';
import 'package:shoping/consts/consts.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:shoping/consts/list.dart';
import 'package:shoping/services/firestore_services.dart';
import 'package:shoping/views/category_screen/categoris_detail.dart';
import 'package:shoping/views/home_screen/componets/featured_button.dart';
import 'package:shoping/views/home_screen/componets/search_screen.dart';
import 'package:shoping/widgets_common/loading_indicator.dart';

import '../../controllers/home_controller.dart';
import '../../widgets_common/home_button.dart';
import '../category_screen/items_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search).onTap(() {
                  if (controller.searchController.text.isNotEmptyAndNotNull) {
                    Get.to(() => SearchScreen(
                          title: controller.searchController.text,
                        ));
                  }
                }),
                border: InputBorder.none,
                filled: true,
                fillColor: whiteColor,
                hintText: searchanything,
                hintStyle: TextStyle(color: textfieldGrey),
              ),
            ).box.outerShadowSm.make(),
          ),

          //swiper brands
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => homeButtons(
                              height: context.screenHeight * 0.14,
                              width: context.screenWidth / 2.5,
                              icon: index == 0 ? icTodaysDeal : icFlashDeal,
                              title: index == 0 ? todaydeal : flashsale,
                            )),
                  ),
                  10.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondsliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  10.heightBox,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => homeButtons(
                                height: context.screenHeight * 0.13,
                                width: context.screenWidth / 3.5,
                                icon: index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? icBrands
                                        : icTopSeller,
                                title: index == 0
                                    ? topCategories
                                    : index == 1
                                        ? brand
                                        : topsellers,
                              ))),
                  10.heightBox,
                  //feature categories
                  Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategories.text
                        .color(darkFontGrey)
                        .size(18)
                        .fontFamily(bold)
                        .make(),
                  ),
                  10.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featuredButton(
                                        icon: featuredList1[index],
                                        title: featuredTitle1[index]),
                                    10.heightBox,
                                    featuredButton(
                                        icon: featuredList2[index],
                                        title: featuredTitle2[index]),
                                  ],
                                )).toList()),
                  ),

                  //featured product
                  20.heightBox,
                  Container(
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(color: redColor),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text
                              .size(18)
                              .fontFamily(bold)
                              .white
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                                future: FireStoreServices.getFeaturedProducts(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: loadingIndicator(),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return "No feature products"
                                        .text
                                        .white
                                        .makeCentered();
                                  } else {
                                    var featuredData = snapshot.data!.docs;
                                    return Row(
                                      children: List.generate(
                                          featuredData.length,
                                          (index) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                      Image.network(
                                                        featuredData[index]
                                                            ['p_img'][0],
                                                        width: 150,
                                                        height: 130,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      10.heightBox,
                                                      "${featuredData[index]['p_name']}"
                                                          .text
                                                          .fontFamily(semibold)
                                                          .color(darkFontGrey)
                                                          .make(),
                                                      10.heightBox,
                                                      "${featuredData[index]['p_price']}"
                                                          .numCurrency
                                                          .text
                                                          .color(redColor)
                                                          .fontFamily(bold)
                                                          .size(16)
                                                          .make(),
                                                    ])
                                                    .box
                                                    .white
                                                    .roundedSM
                                                    .padding(
                                                        const EdgeInsets.all(8))
                                                    .make()
                                                    .onTap(() {
                                                  Get.to(() => itemDetail(
                                                        title:
                                                            "${featuredData[index]['p_name']}",
                                                        data:
                                                            featuredData[index],
                                                      ));
                                                }),
                                              )),
                                    );
                                  }
                                }),
                          )
                        ]),
                  ),

                  //third swiped
                  20.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondsliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: "All Products".text.fontFamily(bold).size(18).make(),
                  ),

                  20.heightBox,
                  StreamBuilder(
                      stream: FireStoreServices.allproducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else {
                          var allproductsdata = snapshot.data!.docs;
                          return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allproductsdata.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 250),
                              itemBuilder: (context, index) {
                                return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Image.network(
                                        allproductsdata[index]['p_img'][0],
                                        width: 200,
                                        height: 180,
                                        fit: BoxFit.contain,
                                      ),
                                      const Spacer(),
                                      "${allproductsdata[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "${allproductsdata[index]['p_price']}"
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .size(16)
                                          .make(),
                                    ])
                                    .box
                                    .white
                                    .roundedSM
                                    .padding(const EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => itemDetail(
                                        title:
                                            "${allproductsdata[index]['p_name']}",
                                        data: allproductsdata[index],
                                      ));
                                });
                              });
                        }
                      })
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
