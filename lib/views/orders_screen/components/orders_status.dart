import 'package:flutter/material.dart';

import 'package:shoping/consts/consts.dart';

Widget OrderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        "$title".text.color(darkFontGrey).make(),
        showDone
            ? const Icon(
                Icons.done,
                color: redColor,
              )
            : Container(),
      ]),
    ),
  );
}
