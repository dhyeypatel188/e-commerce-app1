import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoping/consts/colors.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/consts/list.dart';
import 'package:shoping/controllers/product_controller.dart';
import 'package:shoping/views/chat_screen/chat_screen.dart';
import 'package:shoping/widgets_common/ourbutton.dart';

class itemDetail extends StatelessWidget {
  final String title;
  final dynamic data;
  const itemDetail({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Productcontroller());
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: title.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                )),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishList(data.id, context);
                    } else {
                      controller.addToWishList(data.id, context);
                    }
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  )),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //swipe section
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        itemCount: data['p_img'].length,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data['p_img'][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }),

                    10.heightBox,
                    //title and detailselextion
                    title!.text
                        .size(16)
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    //reating
                    VxRating(
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      maxRating: 5,
                    ),
                    10.heightBox,
                    "${data['p_price']}"
                        .numCurrency
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(18)
                        .make(),

                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Seller".text.white.fontFamily(semibold).make(),
                            5.heightBox,
                            "${data['p_seller']}"
                                .text
                                .white
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .size(16)
                                .make()
                          ],
                        )),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        ).onTap(() {
                          Get.to(
                            () => const ChatScreen(),
                            arguments: [data['p_seller'], data['vendor_id']],
                          );
                        })
                      ],
                    )
                        .box
                        .height(60)
                        .color(textfieldGrey)
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .make(),

                    //color seletions
                    20.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Color : ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                  children: List.generate(
                                      data['p_colors'].length,
                                      (index) => Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              VxBox()
                                                  .size(40, 40)
                                                  .roundedFull
                                                  .color(Color(data['p_colors']
                                                          [index])
                                                      .withOpacity(1.0))
                                                  .margin(EdgeInsets.symmetric(
                                                      horizontal: 6))
                                                  .make()
                                                  .onTap(() {
                                                controller.colorIndex(index);
                                              }),
                                              Visibility(
                                                  visible: index ==
                                                      controller
                                                          .colorIndex.value,
                                                  child: const Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          )))
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),

                          //quantity show
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity: "
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.decreaseQuentity();
                                          controller.calculateTotlePrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: Icon(Icons.remove)),
                                    controller.quentity.value.text
                                        .size(16)
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increaseQuentity(
                                              int.parse(data['p_quantity']));
                                          controller.calculateTotlePrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: Icon(Icons.add)),
                                    10.widthBox,
                                    "(${data['p_quantity']} available)"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ],
                                ),
                              ),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),

                          //total row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Total : ".text.color(textfieldGrey).make(),
                              ),
                              "${controller.totalprice.value}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .size(16)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),

                    //description section
                    10.heightBox,
                    "Description"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    "${data['p_desc']} ".text.color(darkFontGrey).make(),

                    //button section
                    10.heightBox,
                    ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            itemDetailButtonsList.length,
                            (index) => ListTile(
                                  title: "${itemDetailButtonsList[index]}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  trailing: Icon(Icons.arrow_forward),
                                ))),
                    20.heightBox,

                    //Products may like section
                    producsyoumaylike.text
                        .fontFamily(bold)
                        .size(16)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,

                    //i copied this widget from home screen featured products
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Image.asset(
                                          imgP1,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        10.heightBox,
                                        "Laptop 4GB/64GB"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "\$600"
                                            .text
                                            .color(redColor)
                                            .fontFamily(bold)
                                            .size(16)
                                            .make(),
                                      ])
                                      .box
                                      .white
                                      .roundedSM
                                      .padding(const EdgeInsets.all(8))
                                      .make(),
                                )),
                      ),
                    )
                  ],
                ),
              ),
            )),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: ourButton(
                    color: redColor,
                    onPress: () {
                      if (controller.quentity.value > 0) {
                        controller.addToCart(
                            color: data['p_colors']
                                [controller.colorIndex.value],
                            context: context,
                            venderId: data['vendor_id'],
                            img: data['p_img'][0],
                            qty: controller.quentity.value,
                            sellername: data['p_seller'],
                            title: data['p_name'],
                            tprice: controller.totalprice.value);
                        VxToast.show(context, msg: "Add to cart");
                      } else {
                        VxToast.show(context, msg: "Quantity can't be 0");
                      }
                    },
                    textcolor: whiteColor,
                    title: "Add to cart")),
          ],
        ),
      ),
    );
  }
}
