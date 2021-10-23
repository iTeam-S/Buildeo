import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildeo/view/widget/drawer.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreen createState() => _InfoScreen();
  const InfoScreen({Key? key}) : super(key: key);
}

class _InfoScreen extends State<InfoScreen> {

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  AppDrawer drawer = AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: drawer,
      appBar: AppBar(
        leading: IconButton( onPressed: () {
          //Get.to(AppDrawer());
          _key.currentState!.openDrawer();
          },
          icon: const Icon(Icons.sort, color: Colors.white),
        ),
        title: Text("Centre d'information", style: TextStyle(fontSize: 15),),
        backgroundColor: Color(0xffeb3446),
        elevation: 5,
        actions: [
          IconButton(
              icon: Icon(Icons.home_filled, color: Colors.white),
              onPressed: () {
                Get.toNamed('/home');
              })
        ],
      ),
      body:Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 12),
              child: Text("Informations et pièces à fournir",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.blueGrey)
              )
            ),
            Card(
              color: Color(0xffedf7fa),
              elevation: 0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xfffad9dd),
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title: Text(
                    "Délai de traitement : 35 jours",
                    style: TextStyle(color:  Color(0xffeb3446), fontSize: 14),
                  ),
                ),
              ),
            ),
            Card(
              color: Color(0xffedf7fa),
              elevation: 0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffedf7fa),
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title: Text(
                    " En règle général, ci-dessous la liste des pièces en détails à fournir en vu de l’obtention du permis de construire: \n\n a) Alignement \n b) ( 5 ) plans topographiques avec les coordonnées Laborde \n c) ( 3 ) plans de la maison à construire \n d) ( 3 ) plans d’implantation \n e) ( 1 ) certificat Juridique de moins de 3 mois \n\n Tout cela dans une chemise accompagnée d’une demande manuscrite adressée au Maire et au chef du fokontany.\n\n Les pièces à fournir pourraient être différents suivant chaque mairie. Pour Antananarivo ville, il faut se déplacer au CUA (Commune Urbaine d’Antananarivo) à Tsimbazaza pour avoir la liste des pièces. Pour Antananarivo ville,  il existe un formulaire pré imprimé qui est à remplir par le professionnel qui a fait votre plan.",
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 12),
              child: Text("Droit de construction",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.blueGrey)
              )
            ),
            Card(
              color: Color(0xffedf7fa),
              elevation: 0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xfffad9dd),
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  title: Text(
                    "Droit de dépôt : 50000ar",
                    style: TextStyle(color:  Color(0xffeb3446), fontSize: 14),
                  ),
                ),
              ),
            ),   
            Row(children: [
              Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.only(
                  left: Get.width * 0.020,
                ),
                child: Container(
                  width: Get.width * 0.47,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 5),
                      child: Text(
                        "Usage d'habitation (maison)",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                    Text(
                        "3000ar/m2",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xff0cab56), fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                  ]),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.02, vertical: 6.0),
                child: Container(
                  width: Get.width * 0.47,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 5),
                      child: Text(
                        "Usage commercial et industriel",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                    Text(
                        "3000ar/m2",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xff0cab56), fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                  ]),
                ),
              ),
            ]),
            Row(children: [
              Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.only(
                  left: Get.width * 0.020,
                ),
                child: Container(
                  width: Get.width * 0.47,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 5),
                      child: Text(
                        "Mur de clôture",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                    Text(
                        "2000ar/m linéaire",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xff0cab56), fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                  ]),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 4,
                margin: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.02, vertical: 6.0),
                child: Container(
                  width: Get.width * 0.47,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 5),
                      child: Text(
                        "Mur de soutiènement",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                    Text(
                        "2000ar/m3",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xff0cab56), fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                  ]),
                ),
              ),
            ]),
          ]
        )
      ),
    );
  }
}
