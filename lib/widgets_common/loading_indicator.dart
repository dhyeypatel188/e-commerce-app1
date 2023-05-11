import 'package:flutter/material.dart';
import 'package:shoping/consts/colors.dart';

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
