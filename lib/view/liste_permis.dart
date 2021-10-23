// ignore_for_file: prefer_const_constructors

import 'package:buildeo/responsive.dart';
import 'package:buildeo/view/widget/card_validation.dart';
import 'package:buildeo/view/widget/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildeo/view/widget/drawer.dart';

// ignore: must_be_immutable
class ListePermis extends StatelessWidget {
  ListePermis({Key? key}) : super(key: key);

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
                  height: Get.height * .23,
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
                        child: Text("Liste de vos permis",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 30, color: Colors.white)),
                      ),
                    ],
                  )),
              Container(
                height: Get.height * .77,
                decoration: BoxDecoration(
                  color: Color(0xfff0f7ff),
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
                              controller:
                                  ScrollController(keepScrollOffset: false),
                              crossAxisCount: 4,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                /**mettre en boucle pour le fetching */
                                PermisListe(),
                                PermisListe(),
                                CardValidated(),
                                PermisListe(),
                                PermisListe(),
                                PermisListe(),
                              ],
                            );
                          }),
                        )
                      : ListView.builder(
                          itemCount: 7,
                          itemBuilder: (context, id) {
                            return PermisListe();
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

class PermisListe extends StatelessWidget {
  const PermisListe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context, builder: (BuildContext context) => PopDownload());
      },
      child: Card(
          color: Colors.transparent,
          elevation: 0.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            height: 90,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 9.0,
                offset: Offset(0, 3),
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                title: Text(
                  "Demande n°011/21/CR-Fdt",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.watch_later_outlined, color: Colors.black45),
                    Text(" Il y a deux jours",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black45))
                  ],
                ),
                trailing: CircleAvatar(
                    radius: 14,
                    backgroundColor: Color(0xff2ebc4f),
                    child: IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 13,
                      ),
                      onPressed: () {},
                    ))),
          )),
    );
  }
}
