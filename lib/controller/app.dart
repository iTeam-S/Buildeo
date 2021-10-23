// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:buildeo/controller/api.dart';
import 'package:buildeo/model/commune.dart';
import 'package:buildeo/model/user.dart';
import 'package:buildeo/translate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AppController extends GetxController {
  final box = GetStorage();
  // configuration user
  String lang = 'fr';
  User? user;
  List<Commune> communes = <Commune>[];
  // VERIFICATION OPTIONS
  bool isscanning = false;
  TextEditingController numPermisController = TextEditingController();
  TextEditingController qRfiletitre = TextEditingController();
  String qrfilepath = '';
  FocusNode qRfocus = FocusNode();

  // LOGIN
  TextEditingController usrController = TextEditingController();
  TextEditingController passwdController = TextEditingController();

  final ApiController apiController = Get.put(ApiController());

  void login(RoundedLoadingButtonController btnController, usr, passwd) async {
    try {
      var res = await apiController.login(usr, passwd);
      if (res[0]) {
        if (res[1]['status_code'] != 200) {
          Get.snackbar(
            "Erreur",
            translate(res[1]['status'], lang),
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
            borderColor: Colors.red,
            borderRadius: 10,
            borderWidth: 2,
            barBlur: 0,
            duration: const Duration(seconds: 2),
          );
          btnController.reset();
        } else {
          Timer(Duration(seconds: 2), () {
            btnController.reset();
          });
          user = User.fromJson(res[1]['data']);
          box.write('user', jsonEncode(user));
          box.save();
          btnController.success();
          update();
          Get.back();
        }
      } else {
        Get.snackbar(
          "Erreur",
          translate(res[1], lang),
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.red,
          borderRadius: 10,
          borderWidth: 2,
          barBlur: 0,
          duration: const Duration(seconds: 2),
        );
        btnController.reset();
      }
    } catch (e) {
      Get.snackbar(
        translate("erreur", lang),
        translate("erreur_produite", lang),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.red,
        borderRadius: 10,
        borderWidth: 2,
        barBlur: 0,
        duration: const Duration(seconds: 2),
      );
      btnController.reset();
    }
  }

  void getPermis(String permisID) async {
    try {
      var res = await apiController.getPermis(permisID);
      if (res[0]) {
        if (res[1]['status_code'] != 200) {
          Get.bottomSheet(
              SizedBox(
                height: Get.height * .10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          translate("VERIFICATON_PERMIS", lang),
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        translate(res[1]['status'], lang),
                        style: const TextStyle(
                            fontSize: 14, color: Colors.redAccent),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              elevation: 20.0,
              enableDrag: false,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              )));
        } else {
          var data = res[1]['data'];
          Get.bottomSheet(
              SizedBox(
                height: Get.height * .20,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          translate("VERIFICATON_PERMIS", lang),
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        "${data['numero_permis']}",
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xffeb3446)),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${data['demande']}",
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xffeb3446)),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${translate('DELIVRE', lang)} ${data['delivery_date']}",
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xffeb3446)),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${data['adress']}",
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xffeb3446)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              elevation: 20.0,
              enableDrag: false,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              )));
        }
      } else {
        Get.snackbar(
          "Erreur",
          translate(res[1], lang),
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.red,
          borderRadius: 10,
          borderWidth: 2,
          barBlur: 0,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        translate("erreur", lang),
        translate("erreur_produite", lang),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.red,
        borderRadius: 10,
        borderWidth: 2,
        barBlur: 0,
        duration: const Duration(seconds: 2),
      );
    }

    isscanning = false;
    update();
  }

  void getListCommune() async {
    try {
      var res = await apiController.listCommune();
      if (res[0]) {
        if (res[1]['status_code'] != 200) {
          for (Map<String, dynamic> res in res[1]['data']) {
            communes.add(Commune.fromJson(res));
          }
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
