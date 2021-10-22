// ignore: unused_import
import 'dart:async';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';

class AppDrawer extends StatelessWidget {
  final bool isLoadingPath = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  final TextEditingController moduleAddController = TextEditingController();

  final FocusNode focus = FocusNode();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  // stockena donnee ilaina apres fermeture application
  final box = GetStorage();

  AppDrawer({Key? key}) : super(key: key);

  // void _doSomething(RoundedLoadingButtonController controller) async {
  //   Timer(const Duration(seconds: 2), () {
  //     controller.success();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xffeb3446),
                    Color(0xff8a0a16),
                  ],
                ))),
                Container(
                  // alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Column(children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03,
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Color(0xffeb3446),
                              child: Image.asset(
                                'assets/images/logo_b.png',
                                width: 45,
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.only(
                            left: 8,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Buildeo",
                                    style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.black87,
                                    )),
                                const Text("Non connecté",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    )),
                              ]),
                        ),
                      ],
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03,
                        bottom: MediaQuery.of(context).size.height * 0.03,
                      ),
                      child: RoundedLoadingButton(
                        elevation: 0,
                        height: 37,
                        width: 130,
                        controller: _btnController,
                        color: const Color(0xfffad9dd),
                        successColor: Colors.blue,
                        onPressed: () {
                          Get.to('/confirm_pass');
                        },
                        valueColor: Colors.white,
                        borderRadius: 90,
                        child: Text("Se connecter",
                            style: TextStyle(color: Color(0xffeb3446))),
                      ),
                    ),
                    Divider(),
                  ]),
                )
              ],
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.73,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Text("LISTE DES VALIDATIONS",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            )),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: const Color(0xFFFF4800),
                            child: const Icon(
                              Icons.shield_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          title: const Text("Validation administrateurs"),
                          onTap: () {
                            Get.toNamed("/pageAmin");
                          },
                          hoverColor: const Color(0xfffcdfca),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: const Color(0xFFDC06F0),
                            child: const Icon(
                              Icons.select_all_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          title: const Text("Validation de maire"),
                          onTap: () {
                            Get.toNamed("/validMaire");
                          },
                          hoverColor: const Color(0xffe5c2fc),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        Text("PLUS",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                        )),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: const Color(0xFFFF4800),
                            child: const Icon(
                              Icons.sort,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          title: const Text("Liste des permis"),
                          onTap: () {
                          },
                          hoverColor: const Color(0xfffcdfca),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: const Color(0xff0d94bd),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          title: const Text("Faire une demande de permis"),
                          onTap: () {
                          },
                          hoverColor: const Color(0xffceeaf2),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: const Color(0xFFDC06F0),
                            child: const Icon(
                              Icons.info,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          title: const Text("Centre d'information"),
                          onTap: () {
                          },
                          hoverColor: const Color(0xffe5c2fc),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: const Color(0xff0cab56),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          title: const Text("Carte et statistique"),
                          onTap: () {
                            Get.toNamed("/map");
                          },
                          hoverColor: const Color(0xffddffdd),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                        Text("PREFERENCES",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            )),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: const Color(0xff0cab56),
                            child: const Icon(
                              Icons.sort_by_alpha,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          title: const Text("Changer language"),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          trailing: const Icon(Icons.chevron_right),
                          hoverColor: const Color(0xffddffdd),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: const Color(0xff0d94bd),
                            child: const Icon(
                              Icons.info,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          title: const Text("A propos"),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          hoverColor: const Color(0xffceeaf2),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: const Color(0xffeb3446),
                            child: const Icon(
                              Icons.logout_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          title: const Text("Se deconnecter"),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          hoverColor: const Color(0xfffad9dd),
                        ),
                      ]),
                    ]))
          ],
        ),
      ),
    );
  }
}
