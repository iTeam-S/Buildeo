// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:buildeo/controller/upload.dart';
import 'package:buildeo/view/widget/drop_down_search.dart';
import 'package:file_picker/file_picker.dart';
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

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController _payController =
      RoundedLoadingButtonController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final UploadController uploadController = Get.put(UploadController());
  bool isLoadingPath = false;

  void onFocusChange() {
    debugPrint("Focus: " + uploadController.focus.hasFocus.toString());
    if (uploadController.focus.hasFocus) _openFileExplorer();
  }

  dynamic _openFileExplorer() async {
    setState(() => isLoadingPath = true);
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['zip', 'rar', '7z'],
      );
      if (result != null) {
        PlatformFile file = result.files.first;
        uploadController.filepath = file.path.toString();
        uploadController.filename.text = file.name;
        uploadController.update();
      } else {
        print("Annuler");
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    uploadController.focus.addListener(onFocusChange);
    print('okey');
  }

  @override
  Widget build(BuildContext context) {
    uploadController.type = 'Usage d\'habitation';
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffeb3446),
          body: SingleChildScrollView(
            child: GetBuilder<UploadController>(builder: (_) {
              return Column(
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
                                " ${appController.user!.nom}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
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
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(blurRadius: 20.0, color: Colors.black26),
                      ],
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        SizedBox(
                            child: Text(
                          "Veillez saisir les informations requis",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.blueGrey),
                        )),
                        SizedBox(
                          height: 15,
                        ),
                        SingleChildScrollView(
                          child: Form(
                            key: _formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    margin: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      // vertical: MediaQuery.of(context).size.height*0.0110
                                    ),
                                    child: TextField(
                                      controller: uploadController.adresse,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800]),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    margin: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      // vertical: MediaQuery.of(context).size.height*0.0110
                                    ),
                                    child: Dropdowncommune()), //appel
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    margin: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      // vertical: MediaQuery.of(context).size.height*0.0110
                                    ),
                                    child: DropdownButtonFormField<String>(
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
                                        prefixIcon: Icon(Icons.room_preferences,
                                            color: Color(0xffeb3446)),
                                      ),
                                      value: uploadController.type,
                                      icon: const Icon(
                                          Icons.arrow_drop_down_circle,
                                          color: Color(0xffeb3446)),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(color: Colors.grey[800]),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          uploadController.type = newValue!;
                                        });
                                      },
                                      items: <String>[
                                        'Usage d\'habitation',
                                        'Usage comercial',
                                        'Mur de clôture',
                                        'Mur de soutiènement'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    )),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    margin: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      // vertical: MediaQuery.of(context).size.height*0.0110
                                    ),
                                    child: TextField(
                                      focusNode: uploadController.focus,
                                      controller: uploadController.filename,
                                      keyboardType: TextInputType.none,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800]),
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
                                        hintText: ('Pièce joint'),
                                        suffixIcon: CircleAvatar(
                                          backgroundColor: Color(0xffeb3446)
                                              .withOpacity(.09),
                                          child: Icon(Icons.attach_file,
                                              color: Colors.black),
                                        ),
                                        prefixIcon: Icon(Icons.description,
                                            color: Color(0xffeb3446)),
                                      ),
                                    )),
                                SizedBox(
                                  height: 15,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Paiement :",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey.shade600
                                              .withOpacity(.7),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    RoundedLoadingButton(
                                      elevation: 0,
                                      height: 37,
                                      width: 130,
                                      controller: _payController,
                                      color: Colors.white,
                                      successColor: Colors.white,
                                      onPressed: () {
                                        Timer(Duration(seconds: 2), () {
                                          _payController.success();
                                        });
                                      },
                                      valueColor: Color(0xffeb3446),
                                      borderRadius: 90,
                                      child: Text("Payer ici.",
                                          style: const TextStyle(
                                              color: Color(0xffeb3446))),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
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
                            onPressed: () {
                              appController.process(
                                  _btnController,
                                  uploadController.commmune.text,
                                  uploadController.adresse.text,
                                  uploadController.type,
                                  uploadController.filepath);
                            },
                            valueColor: Colors.white,
                            borderRadius: 90,
                            child: Text("DEMANDER",
                                style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          )),
    );
  }
}
