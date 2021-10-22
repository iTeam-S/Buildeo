// ignore_for_file: prefer_const_constructors

import 'package:buildeo/responsive.dart';
import 'package:buildeo/view/widget/cardValidation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValidationMaire extends StatelessWidget {
  const ValidationMaire({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeb3446),
      body: Column(
        children: [
          Column(
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
                      Text("Vos validations en attente ...",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25, color: Colors.white)),
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
                              crossAxisCount: 4,
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
