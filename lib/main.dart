import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/consts/strings.dart';
import 'package:shoping/views/splace_screen/splace_screen.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //we are using getX so we have to cahnge this material app to getmaterialapp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: darkFontGrey)),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
