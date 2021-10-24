// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:buildeo/controller/api.dart';
import 'package:buildeo/controller/upload.dart';
import 'package:buildeo/model/permis.dart';
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
  // resaka permis le rà
  List<Permis> permis = <Permis>[];
  Permis? currentPermis;
  
  List<Commune> communes = <Commune>[];
  // VERIFICATION OPTIONS
  bool isscanning = false;
  TextEditingController numPermisController = TextEditingController();
  TextEditingController qRfiletitre = TextEditingController();
  String qrfilepath = '';
  FocusNode qRfocus = FocusNode();
  final UploadController uploadController = Get.put(UploadController());

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
                height: Get.height * .13,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 2.0, top:10),
                        child: Text(
                          translate("VERIFICATON_PERMIS", lang),
                          style: const TextStyle(fontSize: 17, color: Colors.blueGrey),
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
                height: Get.height * .30,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 4.0, top: 10.0),
                        child: Text(
                          translate("VERIFICATON_PERMIS", lang),
                          style: const TextStyle(fontSize: 17, color: Colors.blueGrey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        "${data['numero_permis']}",
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xff2ebc4f)),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${data['demande']}",
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xff2ebc4f)),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${translate('DELIVRE', lang)} ${data['delivery_date']}",
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xff2ebc4f)),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${data['adress']}",
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xff2ebd4f)),
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
  
  void getAllPermis(int? commune) async {
    try{
      permis.clear();
      var res = await apiController.getallpermis(commune, user!);
      if (res[0]) {
        if (res[1]['status_code'] != 200){
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
          } 
      else {
        Timer(Duration(seconds: 2), (){
        });
        for (Map<String, dynamic> res in res[1]['data']) {
          print(res);
          permis.add(Permis.fromJson(res));
        }
        print("Tsy akeo oo?");
        update();
       
      }
    }
    else {
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
    } } catch (e) {
      print(e);
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
    }}


  void getListCommune() async {
      var res = await apiController.listCommune();
      if (res[0]) {
        if (res[1]['status_code'] == 200) {
          for (Map<String, dynamic> res in res[1]['data']) {
            communes.add(Commune.fromJson(res));
          }
        }
      }

      // ignore: avoid_print
  
    
  }

  void updateStatus(status, motif, permis) async {
      var res = await apiController.updateStatus(status, motif, permis, user);
      if (res[0]) {
         Get.snackbar(
          "Succès",
          "Action effectuée",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.green,
          borderRadius: 10,
          borderWidth: 2,
          barBlur: 0,
          duration: const Duration(seconds: 2),
        );
        Timer(Duration(seconds: 2), (){
          getAllPermis(user!.commune);
          if (status == "VALIDE"){
            Get.toNamed("/validMaire");
          }else {
              Get.toNamed("/pageAmin");
          }
            
        });
      

      // ignore: avoid_print
  
  }}


  Future<dynamic> process(RoundedLoadingButtonController btnController, commune, adresse, type, filepath) async {
    try {
      uploadController.uploadPourcent = 0.0;
      Get.bottomSheet(GetBuilder<UploadController>(
          builder: (_) => Container(
              margin: EdgeInsets.symmetric(
                vertical: Get.height * 0.02,
                horizontal: Get.width * 0.06,
              ),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey,
                value: uploadController.uploadPourcent,
              ))));
              int tmpCommune = 0;
              for (Commune com in communes) {
                if (com.nom == commune) tmpCommune = com.id;
              }
      var res = await apiController.uploadContent(
          user,
          tmpCommune,
          type,
          adresse,
          filepath,
      );
      Get.back();
      if (res[0]) {
        Timer(Duration(seconds: 2), () {
          btnController.reset();
        });
        btnController.success();
        Get.snackbar(
          "Ajout",
          "Le contenue a bien été ajoutée.",
          backgroundColor: Colors.grey,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.grey,
          borderRadius: 10,
          borderWidth: 2,
          barBlur: 0,
          duration: Duration(seconds: 2),
        );
        return true;
      } else {
        btnController.reset();
        Get.snackbar(
          "Erreur",
          "${res[1]}",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          borderColor: Colors.red,
          borderRadius: 10,
          borderWidth: 2,
          barBlur: 0,
          duration: Duration(seconds: 2),
        );
        return false;
      }
    } catch (err) {
      print("4---: $err");
      Get.back();
      Get.snackbar(
        "Erreur",
        "Vérfier votre connexion Internet.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        borderColor: Colors.red,
        borderRadius: 10,
        borderWidth: 2,
        barBlur: 0,
        duration: Duration(seconds: 2),
      );
      btnController.reset();
      return false;
    }
  }
}
