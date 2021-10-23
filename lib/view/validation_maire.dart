// ignore_for_file: prefer_const_constructors

import 'package:buildeo/responsive.dart';
import 'package:buildeo/view/widget/card_validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildeo/view/widget/drawer.dart';

// ignore: must_be_immutable
class ValidationMaire extends StatelessWidget {

  ValidationMaire({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  AppDrawer drawer = AppDrawer();

/*24 is for notification bar on Android*/
  final double itemHeight = (Get.size.height - kToolbarHeight - 24) / 3;
  final double itemWidth = Get.size.width / 1.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: drawer,
      backgroundColor: Color(0xffeb3446),
      body: Column(
        children: [
          Column(
            children: <Widget>[
              Container(
                  height: Get.height * .25,
                  decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xffff365e),
                        Color(0xffeb3446),
                      ],
                    )
                  ),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.sort,
                              color: Colors.white,
                            )
                          ),
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.home_filled,
                              color: Colors.white,
                            )
                          ),
                        ],
                      ),
                      Center(
                        child: Text("Dossier en attente de validation",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25, color: Colors.white)
                        ),
                      ),
                    ],
                  )),
              Container(
                height: Get.height * .75,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    BoxShadow(blurRadius: 20.0, color: Colors.black26),
                  ],
                ),
                child: Center(
                  child: (!isMobile(context))
                      ? SizedBox(
                          width: Get.width,
                          child: OrientationBuilder(
                              builder: (context, orientation) {
                            return GridView.count(
                              childAspectRatio: (itemWidth / itemHeight),
                              controller: new ScrollController(keepScrollOffset: false),
                              crossAxisCount: 4,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                /**mettre en boucle pour le fetching */
                                CardValidated(),
                                CardValidated(),
                                CardValidated(),
                                CardValidated(),
                                CardValidated(),
                                CardValidated(),
                              ],
                            );
                          }),
                        )
                      : ListView.builder(
                          itemCount: 7,
                          itemBuilder: (context, id) {
                            return CardValidated();
                          },
                        ),
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
      ),
    );
  }
}
