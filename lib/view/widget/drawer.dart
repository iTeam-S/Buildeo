// ignore: unused_import
import 'dart:async';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';

class AppDrawer extends StatelessWidget {
  final bool isLoadingPath = false;
  // final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  final TextEditingController moduleAddController = TextEditingController();

  final FocusNode focus = FocusNode();

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
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/cover.jpg',
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.048,
                ),
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blueAccent[500],
                          child: const Text("B"),
                        )),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          top: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: const Text("Buildeo",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1,
                      ),
                      child: const Text("Asministrateur",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white54,
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.73,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      ListTile(
                        leading: Icon(Icons.add_outlined,
                            color: Colors.lightBlue[800]),
                        title: const Text("Permis à valider"),
                        onTap: () {
                          Get.toNamed('/validMaire');
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: Icon(Icons.lock, color: Colors.lightBlue[800]),
                        title: const Text("Changer mot de passe"),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: Icon(Icons.logout_outlined,
                            color: Colors.lightBlue[800]),
                        title: const Text("Deconnexion"),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ]),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'BJJ-Library 0.4.1',
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ]))
        ],
      ),
    );
  }
}
