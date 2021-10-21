// ignore_for_file: prefer_const_constructors
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:buildeo/controller/app.dart';
import 'package:buildeo/translate.dart';
import 'package:buildeo/view/validationMaire.dart';
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
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
  final AppController appController = Get.put(AppController());


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
                               Get.to(ValidationMaire());
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
                        child: Text(translate("DEMANDER_ET_RECEVER", appController.lang), textAlign: TextAlign.center,
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
                          child: Text(translate("DEMANDER", appController.lang),
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
      floatingActionButton: FloatingActionButton(child: Icon(Icons.qr_code_scanner_outlined),elevation: 10, backgroundColor: Color(0xffeb3446), onPressed: (){
       showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text(
                translate("VERIFICATON_PERMIS", appController.lang), textAlign: TextAlign.center, style: TextStyle(fontSize: 18),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              children: [
                Container(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: (){}, icon: Icon(Icons.qr_code_scanner_outlined), label: Text(translate("SCANNER", appController.lang)), style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Color(0xffeb3446), ),),
                    )
                ),
                Divider(color: Colors.white,),
                    Text('--- ${translate("ou", appController.lang)} ---',textAlign: TextAlign.center, style: TextStyle(color: Colors.black38, fontSize: 14),),
                    Divider(color: Colors.white,),
                TextField(
                  style: TextStyle(fontSize: 13, color:  Color(0xffeb3446)),
                  decoration: InputDecoration(
                    fillColor:  Color(0xffeb3446),
                    hintText: translate("NUMERO_DE_PERMIS", appController.lang),
                    prefixIcon: Icon(Icons.edit_outlined, color:  Color(0xffeb3446)),
                    suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.send_rounded, color:  Colors.black38),),
                  ),
                ),
                    Divider(color: Colors.white,),
                    Text('--- ${translate("ou", appController.lang)} ---',textAlign: TextAlign.center, style: TextStyle(color: Colors.black38, fontSize: 14),),
                    Divider(color: Colors.white,),
                TextField(
                  style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                 decoration: InputDecoration(
                    fillColor:  Color(0xffeb3446),
                    hintText: "Qr Code",
                    prefixIcon: Icon(Icons.image_search_rounded, color:  Color(0xffeb3446)),
                    suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.send_rounded, color:  Colors.black38),),
                  ),
                ),
                 Divider(color: Colors.white, height: 20,),
              ],
            ));
      }),
      );

  }
}
