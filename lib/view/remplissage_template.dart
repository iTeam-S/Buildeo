import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:get/get.dart';

class Remplissage extends StatelessWidget {
  const Remplissage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RoundedLoadingButtonController _btnController =
        RoundedLoadingButtonController();
    return Scaffold(
        backgroundColor: Color(0xffeb3446),
        body: ListView(children: [
          Column(
            children: <Widget>[
              Container(
                  height: Get.height * .28,
                  color: Color(0xffeb3446),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      SizedBox(),
                      Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  ExactAssetImage("assets/images/user.png"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Gaetan Jonathan Bakary",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                height: Get.height * .70,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                  boxShadow: [
                    BoxShadow(blurRadius: 20.0, color: Colors.black26),
                  ],
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Veillez saisir les informations requis ici",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.06,
                                // vertical: MediaQuery.of(context).size.height*0.0110
                              ),
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800]),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.teal[60],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  hintText: ('Tél.'),
                                  prefixIcon: Icon(Icons.call,
                                      color: Color(0xffeb3446)),
                                ),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.06,
                                // vertical: MediaQuery.of(context).size.height*0.0110
                              ),
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800]),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.teal[60],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  hintText: ('Nom du propriétaire'),
                                  prefixIcon: Icon(Icons.account_circle,
                                      color: Color(0xffeb3446)),
                                ),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.06,
                                // vertical: MediaQuery.of(context).size.height*0.0110
                              ),
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800]),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.teal[60],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  hintText: ('Adresse du propriétaire'),
                                  prefixIcon: Icon(Icons.location_on,
                                      color: Color(0xffeb3446)),
                                ),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "TERRAIN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.normal),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.06,
                                // vertical: MediaQuery.of(context).size.height*0.0110
                              ),
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800]),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.teal[60],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  hintText: ('Adresse '),
                                  prefixIcon: Icon(Icons.maps_home_work,
                                      color: Color(0xffeb3446)),
                                ),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.06,
                                // vertical: MediaQuery.of(context).size.height*0.0110
                              ),
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800]),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.teal[60],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  hintText: ('superficie'),
                                  prefixIcon: Icon(Icons.terrain,
                                      color: Color(0xffeb3446)),
                                ),
                              )),
                          /*SizedBox(
                            height: 15,
                          ),
                          Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.08,
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.06,
                                // vertical: MediaQuery.of(context).size.height*0.0110
                              ),
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800]),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.teal[60],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  hintText: ('Cadastre immatriculation'),
                                  prefixIcon: Icon(Icons.maps_home_work,
                                      color: Color(0xffeb3446)),
                                ),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.08,
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.06,
                                // vertical: MediaQuery.of(context).size.height*0.0110
                              ),
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800]),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.teal[60],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  hintText: ('Nom du propriétaire'),
                                  prefixIcon: Icon(Icons.maps_home_work,
                                      color: Color(0xffeb3446)),
                                ),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.08,
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.06,
                                // vertical: MediaQuery.of(context).size.height*0.0110
                              ),
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800]),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.teal[60],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  hintText: ('Adresse du propriétaire'),
                                  prefixIcon: Icon(Icons.maps_home_work,
                                      color: Color(0xffeb3446)),
                                ),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.08,
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.06,
                                // vertical: MediaQuery.of(context).size.height*0.0110
                              ),
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800]),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.teal[60],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  hintText: ('superficie'),
                                  prefixIcon: Icon(Icons.maps_home_work,
                                      color: Color(0xffeb3446)),
                                ),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.08,
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.06,
                                // vertical: MediaQuery.of(context).size.height*0.0110
                              ),
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800]),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.teal[60],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide.none),
                                  hintText:
                                      ('Servitudes publiques ou privées grevant le terrain'),
                                  prefixIcon: Icon(Icons.maps_home_work,
                                      color: Color(0xffeb3446)),
                                ),
                              )),*/
                          SizedBox(
                            height: 15,
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
                              color: const Color(0xffeb3446),
                              successColor: Colors.blue,
                              onPressed: () {},
                              valueColor: Colors.white,
                              borderRadius: 90,
                              child: Text("GENERER",
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }
}
