// ignore_for_file: prefer_const_constructors

import 'dart:js';
import 'dart:ui';

import 'package:buildeo/controller/app.dart';
import 'package:buildeo/translate.dart';
import 'package:buildeo/view/widget/card_permis.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';

enum Language { malagasy, frantsay, english }

// ignore: must_be_immutable
class AppDrawer extends StatelessWidget {
  final bool isLoadingPath = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  final TextEditingController moduleAddController = TextEditingController();

  final FocusNode focus = FocusNode();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  final AppController appController = Get.put(AppController());
  // stockena donnee ilaina apres fermeture application
  final box = GetStorage();

  AppDrawer({Key? key}) : super(key: key);

  // void _doSomething(RoundedLoadingButtonController controller) async {
  //   Timer(const Duration(seconds: 2), () {
  //     controller.success();
  //   });
  // }

  Language _site = Language.frantsay;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: GetBuilder<AppController>(
            builder: (_) => ListView(
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
                                      left: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: const Color(0xffeb3446),
                                      child: Image.asset(
                                        'assets/images/logo_b.png',
                                        width: 45,
                                      ),
                                    )),
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Buildeo",
                                            style: TextStyle(
                                              fontSize: 23,
                                              color: Colors.black87,
                                            )),
                                        Text(
                                            translate(
                                                appController.user == null
                                                    ? "NON_CONNECTE"
                                                    : "CONNECTE",
                                                appController.lang),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            )),
                                      ]),
                                ),
                              ],
                            ),
                            const Divider(),
                            Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              child: RoundedLoadingButton(
                                elevation: 0,
                                height: 37,
                                width: 130,
                                controller: _btnController,
                                color: const Color(0xfffad9dd),
                                successColor: Colors.blue,
                                onPressed: () {
                                  if (appController.user == null) {
                                    Navigator.of(context).pop();
                                    loginModal(context);
                                  } else {
                                    Navigator.of(context).pop();
                                    appController.user = null;
                                    box.remove('user');
                                    appController.update();
                                    Get.toNamed('/home');
                                  }
                                },
                                valueColor: Colors.white,
                                borderRadius: 90,
                                child: Text(
                                    translate(
                                        appController.user == null
                                            ? "se_connecter"
                                            : "deconnexion",
                                        appController.lang),
                                    style: const TextStyle(
                                        color: Color(0xffeb3446))),
                              ),
                            ),
                            const Divider(color: Colors.white),
                          ]),
                        )
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: appController.user != null
                                ? [
                                    Column(children: [
                                      if (appController.user!.compte ==
                                              "ADMIN" ||
                                          appController.user!.compte == "MAIRE")
                                        ListTile(
                                          leading: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                const Color(0xFFFF4800),
                                            child: const Icon(
                                              Icons.shield_outlined,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                          title: Text(translate(
                                              "VALIDATION_ADMIN",
                                              appController.lang)),
                                          onTap: () {
                                            appController.getAllPermis(
                                                appController.user!.commune);
                                            Get.toNamed("/pageAmin");
                                          },
                                          hoverColor: const Color(0xfffcdfca),
                                          trailing:
                                              const Icon(Icons.chevron_right),
                                        ),
                                      if (appController.user!.compte == "MAIRE")
                                        ListTile(
                                          leading: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                const Color(0xFFDC06F0),
                                            child: const Icon(
                                              Icons.select_all_outlined,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                          title: Text(translate(
                                              "VALIDATION_MAIRE",
                                              appController.lang)),
                                          onTap: () {
                                            Get.toNamed("/validMaire");
                                          },
                                          hoverColor: const Color(0xffe5c2fc),
                                          trailing:
                                              const Icon(Icons.chevron_right),
                                        ),
                                      if (appController.user!.compte ==
                                              "ADMIN" ||
                                          appController.user!.compte == "MAIRE")
                                        Divider(),
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              const Color(0xFFFF4800),
                                          child: const Icon(
                                            Icons.sort,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                        title: Text(translate("LISTE_PERMIS",
                                            appController.lang)),
                                        onTap: () {
                                          Get.toNamed("/liste");
                                        },
                                        hoverColor: const Color(0xfffcdfca),
                                        trailing:
                                            const Icon(Icons.chevron_right),
                                      ),
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              const Color(0xff0d94bd),
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                        title: Text(translate("DEMANDE_PERMIS",
                                            appController.lang)),
                                        onTap: () {
                                          Get.toNamed('/form');
                                        },
                                        hoverColor: const Color(0xffceeaf2),
                                        trailing:
                                            const Icon(Icons.chevron_right),
                                      ),
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              const Color(0xFF5E00AA),
                                          child: const Icon(
                                            Icons.recent_actors,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                        title: Text(translate(
                                            "LISTE_USER", appController.lang)),
                                        onTap: () {
                                          Get.toNamed('/identite');
                                        },
                                        hoverColor: const Color(0xA4BF9FDA),
                                        trailing:
                                            const Icon(Icons.chevron_right),
                                      ),
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              const Color(0xFFDC06F0),
                                          child: const Icon(
                                            Icons.info,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                        title: Text(translate(
                                            "CENTRE_INFO", appController.lang)),
                                        onTap: () {
                                          Get.toNamed('/info');
                                        },
                                        hoverColor: const Color(0xffe5c2fc),
                                        trailing:
                                            const Icon(Icons.chevron_right),
                                      ),
                                      if (appController.user!.compte ==
                                              "ADMIN" ||
                                          appController.user!.compte == "MAIRE")
                                        ListTile(
                                          leading: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                const Color(0xff0cab56),
                                            child: const Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                          title: Text(translate("CARTE_STAT",
                                              appController.lang)),
                                          onTap: () {
                                            Get.toNamed("/map");
                                          },
                                          hoverColor: const Color(0xffddffdd),
                                          trailing:
                                              const Icon(Icons.chevron_right),
                                        ),
                                      Divider(),
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              const Color(0xff0cab56),
                                          child: const Icon(
                                            Icons.translate,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                        title: Text(translate(
                                            "CHANGE_LANG", appController.lang)),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 1.5,
                                                          sigmaY: 1.5),
                                                      child: SimpleDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        title: Text(
                                                          translate(
                                                              "CHANGE_LANG",
                                                              appController
                                                                  .lang),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        ),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 25,
                                                                horizontal: 25),
                                                        children: [
                                                          Divider(),
                                                          ListTile(
                                                              title: const Text(
                                                                  'Malagasy'),
                                                              leading: Radio(
                                                                value: Language
                                                                    .malagasy,
                                                                groupValue:
                                                                    _site,
                                                                onChanged:
                                                                    (Language?
                                                                        value) {
                                                                  navigator?.pop(
                                                                      context);
                                                                  appController
                                                                          .lang =
                                                                      'mg';
                                                                  appController
                                                                      .update();
                                                                  _site = Language
                                                                      .malagasy;
                                                                },
                                                              ),
                                                              trailing:
                                                                  CircleAvatar(
                                                                radius: 15,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/malagasy.png',
                                                                  width: 20,
                                                                ),
                                                              )),
                                                          ListTile(
                                                              title: const Text(
                                                                  'Français'),
                                                              leading: Radio(
                                                                value: Language
                                                                    .frantsay,
                                                                groupValue:
                                                                    _site,
                                                                onChanged:
                                                                    (Language?
                                                                        value) {
                                                                  navigator?.pop(
                                                                      context);
                                                                  appController
                                                                          .lang =
                                                                      'fr';
                                                                  appController
                                                                      .update();
                                                                  _site = Language
                                                                      .frantsay;
                                                                },
                                                              ),
                                                              trailing:
                                                                  CircleAvatar(
                                                                radius: 15,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/french.png',
                                                                  width: 20,
                                                                ),
                                                              )),
                                                          ListTile(
                                                              title: const Text(
                                                                  'English'),
                                                              leading: Radio(
                                                                value: Language
                                                                    .english,
                                                                groupValue:
                                                                    _site,
                                                                onChanged:
                                                                    (Language?
                                                                        value) {
                                                                  navigator?.pop(
                                                                      context);
                                                                  appController
                                                                          .lang =
                                                                      'en';
                                                                  appController
                                                                      .update();
                                                                  _site = Language
                                                                      .english;
                                                                },
                                                              ),
                                                              trailing:
                                                                  CircleAvatar(
                                                                radius: 15,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/english.png',
                                                                  width: 20,
                                                                ),
                                                              )),
                                                        ],
                                                      )));
                                        },
                                        trailing:
                                            const Icon(Icons.chevron_right),
                                        hoverColor: const Color(0xffddffdd),
                                      ),
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              const Color(0xff0d94bd),
                                          child: const Icon(
                                            Icons.info,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                        title: Text(translate(
                                            "A_PROPOS", appController.lang)),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 1.5,
                                                          sigmaY: 1.5),
                                                      child: SimpleDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 25,
                                                                horizontal: 25),
                                                        children: [
                                                          Center(
                                                            child: CircleAvatar(
                                                              radius: 40,
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffeb3446),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/logo_sb.png',
                                                                width: 45,
                                                              ),
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Text(
                                                                "Buildeo 0.0.1",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black87,
                                                                )),
                                                          ),
                                                          Divider(),
                                                          Center(
                                                            child: Text(
                                                                translate(
                                                                    "APROPOS_TEXT",
                                                                    appController
                                                                        .lang),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black87,
                                                                )),
                                                          ),
                                                          Divider(
                                                            color: Colors.white,
                                                          ),
                                                          Center(
                                                            child: Text(
                                                                translate(
                                                                    "DEVELOP",
                                                                    appController
                                                                        .lang),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .teal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ),
                                                        ],
                                                      )));
                                        },
                                        hoverColor: const Color(0xffceeaf2),
                                      ),
                                    ]),
                                  ]
                                : [
                                    Column(children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              const Color(0xff0d94bd),
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                        title: Text(translate("DEMANDE_PERMIS",
                                            appController.lang)),
                                        onTap: () {
                                          if (appController.user == null){
                                            loginModal(context);
                                          } 
                                          else {
                                            Get.toNamed('/form');
                                          }
                                        },
                                        hoverColor: const Color(0xffceeaf2),
                                        trailing:
                                            const Icon(Icons.chevron_right),
                                      ),
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              const Color(0xFFDC06F0),
                                          child: const Icon(
                                            Icons.info,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                        title: Text(translate(
                                            "CENTRE_INFO", appController.lang)),
                                        onTap: () {
                                          Get.toNamed('/info');
                                        },
                                        hoverColor: const Color(0xffe5c2fc),
                                        trailing:
                                            const Icon(Icons.chevron_right),
                                      ),
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              const Color(0xff0cab56),
                                          child: const Icon(
                                            Icons.translate,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                        title: Text(translate(
                                            "CHANGE_LANG", appController.lang)),
                                        onTap: () {
                                          
                                          
                                                 showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 1.5,
                                                          sigmaY: 1.5),
                                                      child: SimpleDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        title: Text(
                                                          translate(
                                                              "CHANGE_LANG",
                                                              appController
                                                                  .lang),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        ),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 25,
                                                                horizontal: 25),
                                                        children: [
                                                          Divider(),
                                                          ListTile(
                                                              title: const Text(
                                                                  'Malagasy'),
                                                              leading: Radio(
                                                                value: Language
                                                                    .malagasy,
                                                                groupValue:
                                                                    _site,
                                                                onChanged:
                                                                    (Language?
                                                                        value) {
                                                                  navigator?.pop(
                                                                      context);
                                                                  appController
                                                                          .lang =
                                                                      'mg';
                                                                  appController
                                                                      .update();
                                                                  _site = Language
                                                                      .malagasy;
                                                                },
                                                              ),
                                                              trailing:
                                                                  CircleAvatar(
                                                                radius: 15,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/malagasy.png',
                                                                  width: 20,
                                                                ),
                                                              )),
                                                          ListTile(
                                                              title: const Text(
                                                                  'Français'),
                                                              leading: Radio(
                                                                value: Language
                                                                    .frantsay,
                                                                groupValue:
                                                                    _site,
                                                                onChanged:
                                                                    (Language?
                                                                        value) {
                                                                  navigator?.pop(
                                                                      context);
                                                                  appController
                                                                          .lang =
                                                                      'fr';
                                                                  appController
                                                                      .update();
                                                                  _site = Language
                                                                      .frantsay;
                                                                },
                                                              ),
                                                              trailing:
                                                                  CircleAvatar(
                                                                radius: 15,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/french.png',
                                                                  width: 20,
                                                                ),
                                                              )),
                                                          ListTile(
                                                              title: const Text(
                                                                  'English'),
                                                              leading: Radio(
                                                                value: Language
                                                                    .english,
                                                                groupValue:
                                                                    _site,
                                                                onChanged:
                                                                    (Language?
                                                                        value) {
                                                                  navigator?.pop(
                                                                      context);
                                                                  appController
                                                                          .lang =
                                                                      'en';
                                                                  appController
                                                                      .update();
                                                                  _site = Language
                                                                      .english;
                                                                },
                                                              ),
                                                              trailing:
                                                                  CircleAvatar(
                                                                radius: 15,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/english.png',
                                                                  width: 20,
                                                                ),
                                                              )),
                                                        ],
                                                      )));
                                     
                                          
                                          
                                               },
                                        trailing:
                                            const Icon(Icons.chevron_right),
                                        hoverColor: const Color(0xffddffdd),
                                      ),
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              const Color(0xff0d94bd),
                                          child: const Icon(
                                            Icons.info,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                        title: Text(translate(
                                            "A_PROPOS", appController.lang)),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 1.5,
                                                          sigmaY: 1.5),
                                                      child: SimpleDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 25,
                                                                horizontal: 25),
                                                        children: [
                                                          Center(
                                                            child: CircleAvatar(
                                                              radius: 40,
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffeb3446),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/logo_sb.png',
                                                                width: 45,
                                                              ),
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Text(
                                                                "Buildeo 0.0.1",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black87,
                                                                )),
                                                          ),
                                                          Divider(),
                                                          Center(
                                                            child: Text(
                                                                translate(
                                                                    "APROPOS_TEXT",
                                                                    appController
                                                                        .lang),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black87,
                                                                )),
                                                          ),
                                                          Divider(
                                                            color: Colors.white,
                                                          ),
                                                          Center(
                                                            child: Text(
                                                                translate(
                                                                    "DEVELOP",
                                                                    appController
                                                                        .lang),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .teal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ),
                                                        ],
                                                      )));
                                        },
                                        hoverColor: const Color(0xffceeaf2),
                                      ),
                                    ]),
                                  ]))
                  ],
                )),
      ),
    );
  }

  void loginModal(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
              child: SimpleDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Text(
                  translate("se_connecter", appController.lang),
                  textAlign: TextAlign.center,
                ),
                contentPadding: EdgeInsets.only(
                    right: 20, left: 20, top: Get.width * .05, bottom: 10),
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Card(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                          child: Form(
                              // autovalidateMode:
                              //     AutovalidateMode.onUserInteraction,
                              child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.06,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.0113),
                                child: TextFormField(
                                  controller: appController.usrController,
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[800]),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.red[50],
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(90.0)),
                                        borderSide: BorderSide.none),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(90.0)),
                                        borderSide: BorderSide.none),
                                    hintText: translate(
                                        'email_ou_numero_telephone',
                                        appController.lang),
                                    prefixIcon: const Icon(Icons.person,
                                        color: Color(0xffeb3446)),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.06),
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: TextFormField(
                                  controller: appController.passwdController,
                                  style: const TextStyle(
                                      fontSize: 13, color: Color(0xffeb3446)),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.red[50],
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(90.0)),
                                        borderSide: BorderSide.none),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(90.0)),
                                        borderSide: BorderSide.none),
                                    hintText: translate(
                                        'mot_de_passe', appController.lang),
                                    prefixIcon: const Icon(Icons.lock,
                                        color: Color(0xffeb3446)),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      Get.toNamed('/forgot');
                                    },
                                    child: Text(
                                      translate('mot_de_passe_oublie_?',
                                          appController.lang),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontFamily: "ProductSans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.06,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                child: RoundedLoadingButton(
                                  color: const Color(0xffeb3446),
                                  successColor: Colors.teal[700],
                                  controller: _btnController,
                                  onPressed: () {
                                    appController.login(
                                        _btnController,
                                        appController.usrController.text,
                                        appController.passwdController.text);
                                  },
                                  valueColor: Colors.white,
                                  borderRadius: 90,
                                  child: Text(
                                      translate("Se connecter",
                                              appController.lang)
                                          .toUpperCase(),
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          )))),
                ],
              ),
            ));
  }
}
