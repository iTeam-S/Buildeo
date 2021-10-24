// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:buildeo/model/permis.dart';
import 'package:shimmer/shimmer.dart';
import 'package:buildeo/controller/app.dart';
import 'package:buildeo/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildeo/view/widget/card_permis.dart';
import 'package:buildeo/view/widget/drawer.dart';

late final height, width;

// ignore: must_be_immutable
class AdminPage extends StatelessWidget {
  AdminPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  AppDrawer drawer = AppDrawer();
  final AppController appController = Get.put(AppController());
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: drawer,
      backgroundColor: Color(0xffeb3446),
      body: GetBuilder<AppController>(
        builder: (_) {
          return Column(
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
                    )
                  ),
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
                            )
                          ),
                          IconButton(
                            onPressed: () {

                            },
                            icon: Icon(
                              Icons.home_filled,
                              color: Colors.white,
                            )
                          ),
                        ],
                      ),
                      Center(
                        child: Text("Demandes en attente (${appController.permis.where((element) => element.status == 'ATTENTE_TRTM' && element.trtUserID == null).toList().length})",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 22, color: Colors.white)
                        ),
                      ),
                    ],
                  )),
              Container(
                height: Get.height * .84,
                decoration: BoxDecoration(
                  color: Color(0xfff0f7ff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(blurRadius: 20.0, color: Colors.black26),
                  ],
                ),
                child: appController.permis.isEmpty ? SizedBox(
                  width: Get.width,
                  child: Shimmer.fromColors(
                      baseColor:  Colors.white,
                      highlightColor: Color(0xfff0f7ff),
                      period: Duration(seconds: 2),
                      child: ListView(
                        children: [myContainer(),myContainer(),myContainer() ]
                        ),
                      ),
                ) : 
                
                (!isMobile(context))
                    ? SizedBox(
                        width: Get.width,
                        child: OrientationBuilder(builder: (context, orientation) {
                          return GridView.count(
                            crossAxisCount: 4,
                            children: [
                              for (Permis perm in appController.permis)
                                if (perm.status == 'ATTENTE_TRTM' && perm.trtUserID == null)
                                  cardListePermis(perm, appController.permis.where((element) => element.status == 'ATTENTE_TRTM' && element.trtUserID == null).toList())
                            ],
                          );
                        }),
                      )
                    :  SizedBox(width: Get.width,
                    child: ListView(
                    
                      children: [
                        for (Permis perm in appController.permis)
                          if (perm.status != 'ATTENTE_TRTM' && perm.trtUserID == null)
                            cardListePermis(perm, appController.permis.where((element) => element.status == 'ATTENTE_TRTM' && element.trtUserID == null).toList())
                      ],
                    ),)
                    //for (Permis perm in  appController.permis)
                    //myContainer(perm)
                     
              ),
            ],
          );
        }
      ),
    );
  }
}

/*


 */