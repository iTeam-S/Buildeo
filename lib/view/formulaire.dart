import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
  const FormPage({Key? key}) : super(key: key);
}

class _FormPageState extends State<FormPage> {
  //TextController to read text entered in text field
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffeb3446),
        body: Column(
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
              height: Get.height * 0.03,
            ),
            Container(
              height: Get.height * .69,
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
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                    hintText: ('Adresse de construction'),
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
                                    hintText: ('Commune'),
                                    prefixIcon: Icon(Icons.location_city,
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
                                    hintText: ('Type de construction'),
                                    prefixIcon: Icon(Icons.roofing,
                                        color: Color(0xffeb3446)),
                                  ),
                                )),
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
                                child: Text("DEMANDER",
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
