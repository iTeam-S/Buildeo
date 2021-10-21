// ignore_for_file: prefer_const_constructors
import 'package:buildeo/view/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  AppDrawer drawer = AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      body: Container(
        alignment: Alignment.center,
        color: Color(0xfffefefe),
        child: ListView(
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
                    top: MediaQuery.of(context).size.height * 0,
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.02,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                //
                                drawer.scaffoldKey.currentState!.openEndDrawer();
                              }, icon: Icon(Icons.sort, color: Colors.white),
                            ),
                            Text(
                              "Buildeo",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                              )
                            ),
                          ],
                        )
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: Get.width * 0.8,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.04,
                        ),
                        child: const Text("Demandez et recevez votre permis de construction via Buildeo", textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14.5, color: Colors.white)
                        )
                      ),
                      
                      Container(
                        alignment: Alignment.centerLeft,
                        width: Get.width * 0.6,
                        margin: EdgeInsets.only(
                          // left: MediaQuery.of(context).size.width * 0.15,
                          top: MediaQuery.of(context).size.height * 0.03,
                        ),
                        child: RoundedLoadingButton(
                          controller: _btnController,
                          color: Color(0xffeb3446),
                          successColor: Colors.blue,
                          onPressed: () {
                            Get.to('/confirm_pass');
                          },
                          valueColor: Colors.white,
                          borderRadius: 90,
                          child: Text("Faire une demande",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
