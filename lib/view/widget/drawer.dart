import 'package:buildeo/controller/app.dart';
import 'package:buildeo/translate.dart';
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

  final AppController appController = Get.put(AppController());
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                 Text("Buildeo",
                                    style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.black87,
                                    )),
                                 Text("Non connecté",
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
                          Navigator.of(context).pop();
                          loginModal(context);
                        },
                        valueColor: Colors.white,
                        borderRadius: 90,
                        child: Text(translate("Se_connecter", appController.lang),
                            style: const TextStyle(color: Color(0xffeb3446))),
                      ),
                    ),
                   const Divider(),
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
                          title: const Text("Validation admin"),
                          onTap: () {
                            Get.toNamed("/pageAmin");
                          },
                          hoverColor: const Color(0xfffcdfca),
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
                          title: const Text("Validation maire"),
                          onTap: () {
                            Get.toNamed("/validMaire");
                          },
                          hoverColor: const Color(0xffe5c2fc),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: const Color(0xFFEAFC47),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          title: const Text("Map"),
                          onTap: () {
                            Get.toNamed("/map");
                          },
                          hoverColor: const Color(0xffceeaf2),
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
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          // left: MediaQuery.of(context).size.width * 0.15,
                          bottom: MediaQuery.of(context).size.height * 0.08,
                        ),
                        child: const Text(
                          "Buileo 0.0.1",
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ]))
          ],
        ),
      ),
    );
  }

  void loginModal(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text(translate("se_connecter", appController.lang), textAlign: TextAlign.center,),
              contentPadding: const EdgeInsets.only(right: 20, left: 20, top: 50),
              children: [
                  SizedBox(
                              height: MediaQuery.of(context).size.height * 0.40,
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
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.08,
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.06,
                                                vertical: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.0113),
                                            child: TextFormField(
                                             
                                              onSaved: (value) {
                                             
                                              },
                                              validator: (value) {
                                              
                                              },
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey[800]),
                                              decoration:  InputDecoration(
                                                filled: true,
                                                fillColor: Colors.red[50],
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.auto,
                                                border: const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                90.0)),
                                                    borderSide:
                                                        BorderSide.none),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    90.0)),
                                                        borderSide:
                                                            BorderSide.none),
                                                hintText:  translate('email_ou_numero_telephone', appController.lang),
                                                prefixIcon: const Icon(Icons.person,
                                                    color:
                                                        Color(0xffeb3446)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.06),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.08,
                                            child: TextFormField(
                                              
                                              onSaved: (value) {
                                              
                                              },
                                              validator: (value) {
                                               
                                              },
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xffeb3446)),
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.red[50],
                                                border: const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                90.0)),
                                                    borderSide:
                                                        BorderSide.none),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    90.0)),
                                                        borderSide:
                                                            BorderSide.none),
                                                hintText: translate('mot_de_passe', appController.lang),
                                                prefixIcon: const Icon(Icons.lock,
                                                    color:
                                                        Color(0xffeb3446)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            margin: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02,
                                            ),
                                            child: TextButton(
                                                onPressed: () {
                                                  Get.toNamed('/forgot');
                                                },
                                                child: Text(
                                                  translate('mot_de_passe_oublie_?', appController.lang),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.grey[400],
                                                      fontFamily: "ProductSans",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                )),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.06,
                                                vertical: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.03),
                                            child: RoundedLoadingButton(
                                              color: const Color(0xffeb3446),
                                              successColor: Colors.blue,
                                              controller: _btnController,
                                              onPressed: () {
                                               
                                              },
                                              valueColor: Colors.white,
                                              borderRadius: 90,
                                              child: Text(translate("Se connecter", appController.lang).toUpperCase(),
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      )))),
                      
              ],
            ));
}

}
