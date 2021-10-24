// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:buildeo/controller/app.dart';
import 'package:buildeo/model/permis.dart';
import 'package:buildeo/responsive.dart';
import 'package:buildeo/view/widget/card_permis.dart';
import 'package:buildeo/view/widget/card_validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildeo/view/widget/drawer.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ValidationMaire extends StatelessWidget {
  ValidationMaire({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  AppDrawer drawer = AppDrawer();
  final AppController appController = Get.put(AppController());

/*24 is for notification bar on Android*/
  final double itemHeight = (Get.size.height - kToolbarHeight - 24) / 3;
  final double itemWidth = Get.size.width / 1.8;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: drawer,
        backgroundColor: Color(0xffeb3446),
        body: GetBuilder<AppController>(
          builder: (_) {
            return Column(
              children: [
                Column(
                  children: <Widget>[
                    Container(
                        height: Get.height * .16,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffff365e),
                            Color(0xffeb3446),
                          ],
                        )),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      //Get.to(AppDrawer());
                                      _key.currentState!.openDrawer();
                                    },
                                    icon: Icon(
                                      Icons.sort,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Icons.home_filled,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                            Center(
                              child: Text("Dossier en attente de validation (${appController.permis.where((element) => element.status == 'ATTENTE_VALIDATION').toList().length})",
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(fontSize: 22, color: Colors.white)),
                            ),
                          ],
                        )),
                    Container(
                      height: Get.height * .797,
                      decoration: BoxDecoration(
                        color: Color(0xfff0f7ff),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(blurRadius: 20.0, color: Colors.black26),
                        ],
                      ),
                      child: Center(
                        child: 
                        appController.permis.isEmpty ? 
                        SizedBox(
                    width: Get.width,
                    child: Shimmer.fromColors(
                        baseColor:  Colors.white,
                        highlightColor: Color(0xfff0f7ff),
                        period: Duration(seconds: 2),
                        child: ListView(
                          children: [myContainer(),myContainer(),myContainer() ]
                          ),
                        ),
                  ) 
                        :
                        (!isMobile(context))
                            ? SizedBox(
                                width: Get.width,
                                child: OrientationBuilder(
                                    builder: (context, orientation) {
                                  return GridView.count(
                                    childAspectRatio: (itemWidth / itemHeight),
                                    controller:
                                        ScrollController(keepScrollOffset: false),
                                    crossAxisCount: 4,
                                    children: [
                                      /**mettre en boucle pour le fetching */
                                  for (Permis perm in appController.permis)
                                    if (perm.status == 'ATTENTE_VALIDATION')
                                      cardValidated(perm)
                                    ],
                                  );
                                }),
                              )
                            : SizedBox(width: Get.width,
                      child: ListView(
                        children: [
                          for (Permis perm in appController.permis)
                            if (perm.status == 'ATTENTE_VALIDATION')
                              cardValidated(perm)
                        ],
                      ),)
                      ),
                      /*ListView.builder(
                        itemCount: 7,
                        itemBuilder: (context, id) {
                          return CardValidated();
                        },
                      ),*/
                    )
                  ],
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
