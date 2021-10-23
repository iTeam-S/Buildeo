import 'package:buildeo/view/formulaire.dart';
import 'package:buildeo/view/info.dart';
import 'package:buildeo/view/admin_page.dart';
import 'package:buildeo/view/map.dart';
import 'package:buildeo/view/validation_admin.dart';
import 'package:buildeo/view/validation_maire.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildeo/view/splash.dart';
import 'package:buildeo/view/home.dart';
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
    Future.delayed(const Duration(milliseconds: 3000), () {
      Get.offNamed('/home');
    });

    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xffeb3446),
        primarySwatch: Colors.red,
        fontFamily: "ProductSans",
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/validMaire': (context) => ValidationMaire(),
        '/validAmin': (context) => ValidationAdmin(),
        '/pageAmin': (context) => AdminPage(),
        '/map': (context) => const CarteView(),
        '/info': (context) => const InfoScreen(),
        '/form': (context) => const FormPage()
      },
    );
  }
}
