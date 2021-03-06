import 'dart:convert';

import 'package:buildeo/controller/app.dart';
import 'package:buildeo/model/user.dart';
import 'package:buildeo/view/formulaire.dart';
import 'package:buildeo/view/gestion_user.dart';
import 'package:buildeo/view/info.dart';
import 'package:buildeo/view/admin_page.dart';
import 'package:buildeo/view/liste_permis.dart';

import 'package:buildeo/view/map.dart';
import 'package:buildeo/view/remplissage_template.dart';
//import 'package:buildeo/view/remplissage_template.dart';
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
  final AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (box.hasData('user')) {
        appController.user = User.fromJson(jsonDecode(box.read('user')));
      }
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
        '/form': (context) => const FormPage(),
        '/remplir': (context) => const Remplissage(),
        '/liste': (context) => ListePermis(),
        '/identite': (context) => GestionUser()
      },
    );
  }
}
