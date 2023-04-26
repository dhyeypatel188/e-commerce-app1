import 'package:flutter/material.dart';
import 'package:shoping/consts/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: "Cart is empty!"
          .text
          .fontFamily(semibold)
          .color(darkFontGrey)
          .makeCentered(),
    );
  }
}
