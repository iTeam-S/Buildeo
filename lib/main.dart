import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildeo/view/splash.dart';
import 'package:get_storage/get_storage.dart';


void main() async {
  await GetStorage.init();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key);

  final box = GetStorage();


  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 2000), () {
      Get.offNamed('/');
    });

    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlue[800],
        primarySwatch: Colors.blue,
        fontFamily: "ProductSans",
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
      },
    );
  }
}
