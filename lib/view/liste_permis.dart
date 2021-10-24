// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:buildeo/controller/app.dart';
import 'package:buildeo/model/permis.dart';
import 'package:buildeo/responsive.dart';
import 'package:buildeo/view/widget/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildeo/view/widget/drawer.dart';

// ignore: must_be_immutable
class ListePermis extends StatelessWidget {
  ListePermis({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  AppDrawer drawer = AppDrawer();
  final AppController appController = Get.put(AppController());

/*24 is for notification bar on Android*/
  final double itemHeight = (Get.size.height - kToolbarHeight - 24) / 3;
  final double itemWidth = Get.size.width / 1.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: drawer,
      backgroundColor: Color(0xffeb3446),
      body: GetBuilder<AppController>(builder: (_) {
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
                          child: Text(
                              "Liste de vos demandes (${appController.permis.where((element) => element.reqUserID == appController.user!.id).toList().length})",
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
                    // ignore:
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
                                  children: [
                                    /**mettre en boucle pour le fetching */
                                    for (Permis perm in appController.permis)
                                      if (perm.reqUserID ==
                                          appController.user!.id)
                                        permisListe(perm, context)
                                  ],
                                );
                              }),
                            )
                          : SizedBox(
                              width: Get.width,
                              child: ListView(
                                children: [
                                  for (Permis perm in appController.permis)
                                    if (perm.reqUserID ==
                                        appController.user!.id)
                                      permisListe(perm, context)
                                ],
                              ),
                            )),
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
      }),
    );
  }
}

Widget permisListe(perm, context) {
  return InkWell(
      onTap: () {
        if (perm.status == 'VALIDE') {
          showDialog(
              context: context,
              builder: (BuildContext context) => PopDownload(
                    permis: perm,
                  ));
        }
      },
      child: Card(
        color: Colors.transparent,
        elevation: 8.0,
        margin: EdgeInsets.only(
          left: Get.height * .01,
          right: Get.height * .01,
          top: Get.width * .01,
          bottom: isMobile(context) ? Get.width * .01 : 0,
        ),
        child: Container(
            height: isMobile(context) ? Get.height * 0.15 : Get.height * 0.4,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 9.0,
                offset: Offset(0, 3),
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                //mainAxisSize: MainAxisSize.max,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Demande n° ${perm.id}",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  isMobile(context)
                      ? Container(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Color(0xfff0f7ff),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: perm.status == 'VALIDE'
                              ? Text(
                                  "Validé",
                                  style: TextStyle(color: Color(0xff2ebc4f)),
                                )
                              : perm.status == 'EN_TRTM'
                                  ? Text(
                                      "En traitement",
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  : perm.status == 'ATTENTE_VALIDATION'
                                      ? Text("En Attente de validation",
                                          style: TextStyle(
                                              color: Colors.yellow.shade900))
                                      : Text(
                                          "En Attente de traitement",
                                          style: TextStyle(color: Colors.black),
                                        ),
                        )
                      : Container(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: perm.status == 'VALIDE'
                              ? CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Color(0xff2ebc4f),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 13,
                                    ),
                                    onPressed: () {},
                                  ))
                              : perm.status == 'EN_TRTM'
                                  ? CircleAvatar(
                                      radius: 14,
                                      backgroundColor: Colors.blue,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.autorenew,
                                          color: Colors.white,
                                          size: 13,
                                        ),
                                        onPressed: () {},
                                      ))
                                  : perm.status == 'ATTENTE_VALIDATION'
                                      ? CircleAvatar(
                                          radius: 14,
                                          backgroundColor:
                                              Colors.yellow.shade900,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.published_with_changes,
                                              color: Colors.white,
                                              size: 13,
                                            ),
                                            onPressed: () {},
                                          ))
                                      : CircleAvatar(
                                          radius: 14,
                                          backgroundColor: Colors.black,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.update,
                                              color: Colors.white,
                                              size: 13,
                                            ),
                                            onPressed: () {},
                                          )),
                        )
                ],
              ),
              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
              subtitle: Text("${perm.reqDate.split(' ')[0]}",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black45)),
            )),
      ));
}


/**
 * CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: Icon(
                      Icons.update,
                      color: Colors.white,
                      size: 13,
                    ),
                    onPressed: () {
                     
                    },
                  ))
 */