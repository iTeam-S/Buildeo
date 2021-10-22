// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:buildeo/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/cardPermis.dart';

late final height, widht;

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeb3446),
      body: Column(
        children: <Widget>[
          Container(
              height: Get.height * .25,
              color: Color(0xffeb3446),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  Center(
                    child: Text("Vos demande de permis de construction",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                  ),
                  SizedBox(),
                ],
              )),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Container(
            height: Get.height * .72,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
              boxShadow: [
                BoxShadow(blurRadius: 20.0, color: Colors.black26),
              ],
            ),
            child: (!isMobile(context))
                ? SizedBox(
                    width: Get.width,
                    child: OrientationBuilder(builder: (context, orientation) {
                      return GridView.count(
                        crossAxisCount: 4,
                        children: [
                          /**mettre en boucle pour le fetching */
                          MyContainer(),
                          MyContainer(),
                          MyContainer(),
                          MyContainer(),
                          MyContainer(),
                          MyContainer(),
                        ],
                      );
                    }),
                  )
                : ListView.builder(
                    itemCount: 7,
                    itemBuilder: (context, id) {
                      return MyContainer();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/*


 */