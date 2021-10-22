import 'package:buildeo/controller/api.dart';
import 'package:buildeo/translate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppController extends GetxController {
  String lang = 'fr';
  // VERIFICATION OPTIONS
  bool isscanning = false;
  TextEditingController numPermisController = TextEditingController();
  TextEditingController qRfiletitre = TextEditingController();
  String qrfilepath = '';
    FocusNode qRfocus = FocusNode();

  final ApiController apiController = Get.put(ApiController());

   void getPermis(String permisID) async {
    try {
      var res = await apiController.getPermis(permisID);
      if (res[0]) {
        if (res[1]['status_code'] != 200){
        Get.bottomSheet(
            SizedBox(
              height: Get.height * .10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        translate("VERIFICATON_PERMIS", lang),
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(translate(res[1]['status'], lang), style: const TextStyle(fontSize: 14, color: Colors.redAccent),
                        textAlign: TextAlign.center,),
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
        }else {
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
                      margin:
                          const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        translate("VERIFICATON_PERMIS", lang),
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text("${data['numero_permis']}", style: const TextStyle(fontSize: 14, color: Color(0xffeb3446)),
                        textAlign: TextAlign.center,),
                    Text("${data['demande']}", style: const TextStyle(fontSize: 14, color: Color(0xffeb3446)),
                        textAlign: TextAlign.center,),
                    Text("${translate('DELIVRE', lang)} ${data['delivery_date']}", style: const TextStyle(fontSize: 14, color: Color(0xffeb3446)),
                    textAlign: TextAlign.center,),
                    Text("${data['adress']}", style: const TextStyle(fontSize: 14, color: Color(0xffeb3446)),
                    textAlign: TextAlign.center,),
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
  
}