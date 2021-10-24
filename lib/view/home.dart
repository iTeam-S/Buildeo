// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'dart:ui';
import 'package:buildeo/controller/api.dart';
import 'package:buildeo/controller/app.dart';
import 'package:buildeo/responsive.dart';
import 'package:buildeo/translate.dart';
// ignore: unused_import
import 'package:buildeo/view/widget/card_permis.dart';
import 'package:buildeo/view/widget/drawer.dart';
import 'package:file_picker/file_picker.dart';

//import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final AppController appController = Get.put(AppController());

  // Utiliser sur QR Code
  late OverlayEntry overlayEntry;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  QRViewController? controller;
  bool isLoadingPath = false;

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void onFocusChange() {
    debugPrint("Focus: " + appController.qRfocus.hasFocus.toString());
    if (appController.qRfocus.hasFocus) _openFileExplorer();
  }

  @override
  void initState() {
    super.initState();
    appController.qRfocus.addListener(onFocusChange);
    if (appController.user != null) {
      appController.getListCommune();
    }
  }

  dynamic _openFileExplorer() async {
    setState(() => isLoadingPath = true);
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.any);
      if (result != null) {
        PlatformFile file = result.files.first;
        appController.qrfilepath = file.path.toString();
        appController.qRfiletitre.text = file.name;
      } else {
        // ignore: avoid_print
        print("Annuler");
      }
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print("Unsupported operation" + e.toString());
    }
  }

  AppDrawer drawer = AppDrawer();

  @override
  void reassemble() {
    super.reassemble();
    try {
      if (Platform.isAndroid) {
        controller!.pauseCamera();
      }
      controller!.resumeCamera();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: drawer,
      body: GetBuilder<AppController>(builder: (_) {
        return Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: ListView(
            children: [
              Stack(
                children: [
                  Image.asset(
                    isMobile(context)
                        ? 'assets/images/cover.jpg'
                        : 'assets/images/cover2.jpg',
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
                                    //Get.to(AppDrawer());
                                    _key.currentState!.openDrawer();
                                  },
                                  icon: const Icon(Icons.sort,
                                      color: Colors.white),
                                ),
                                const Text("Buildeo",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    )),
                              ],
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: Get.width * 0.8,
                            margin: EdgeInsets.only(
                              top: isMobile(context)
                                  ? Get.height * 0.044
                                  : Get.width * 0.075,
                            ),
                            child: Text(
                                translate(
                                    "DEMANDER_ET_RECEVER", appController.lang),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Get.width * 0.042,
                                    color: Colors.white))),
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
                              Get.toNamed('/form');
                            },
                            valueColor: Colors.white,
                            borderRadius: 90,
                            child: Text(
                                translate("DEMANDER", appController.lang),
                                style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 25, left: 12, bottom: 15),
                  child: Text(translate("CENTRE_INFO", appController.lang),
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey))),
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
                      translate("INFO_COURTE", appController.lang),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: RoundedLoadingButton(
                        elevation: 0,
                        height: 37,
                        width: 130,
                        controller: _btnController,
                        color: const Color(0xfffad9dd),
                        successColor: Colors.blue,
                        onPressed: () {
                          Get.toNamed('/info');
                        },
                        valueColor: Color(0xffeb3446),
                        borderRadius: 90,
                        child: Text(translate("VOIR", appController.lang),
                            style: TextStyle(color: Color(0xffeb3446))),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25, left: 12, bottom: 15),
                child: Text(translate("SERVICES", appController.lang),
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey)),
              ),
              Row(children: [
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.only(
                    left: Get.width * 0.015,
                  ),
                  child: Container(
                    width: Get.width * 0.31,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 9.0,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      CircleAvatar(
                          radius: Get.height * 0.04,
                          backgroundColor: Color(0xffeb3446),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ))),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                          translate("DEMANDE_PERM_CONST", appController.lang),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                        ),
                      ),
                    ]),
                  ),
                ),
                Card(
                  color: Colors.white,
                  elevation: 2,
                  margin: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.02, vertical: 6.0),
                  child: Container(
                    width: Get.width * 0.31,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 9.0,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      CircleAvatar(
                          radius: Get.height * 0.04,
                          backgroundColor: Color(0xff52a0ff),
                          child: Icon(
                            Icons.qr_code_scanner,
                            color: Colors.white,
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                          translate(
                              "VERIFICATION_PERM_CONST", appController.lang),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                        ),
                      ),
                    ]),
                  ),
                ),
                Card(
                  color: Colors.white,
                  elevation: 2,
                  margin: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.001, vertical: 6.0),
                  child: Container(
                    width: Get.width * 0.31,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 9.0,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      CircleAvatar(
                          radius: Get.height * 0.04,
                          backgroundColor: Color(0xff15d48e),
                          child: Icon(
                            Icons.text_fields,
                            color: Colors.white,
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                          translate("DOWN_MOD_LETTRES", appController.lang),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                        ),
                      ),
                    ]),
                  ),
                )
              ]),
              Container(
                margin: EdgeInsets.only(top: 25, left: 12, bottom: 15),
                child: Text(translate("MOD_LETTRES", appController.lang),
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey)),
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 9.0,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      Image.asset('assets/images/docx.png',
                          width: Get.width * 0.13),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                          translate("MOD_FOK", appController.lang),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black87, fontSize: 14),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                _launchURL(
                                    "$baseUrlprotocol/download/model/formulaire_demande_permis.pdf");
                              },
                              icon: Icon(Icons.download,
                                  size: 20, color: Colors.black54)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit,
                                  size: 20, color: Colors.black54)),
                        ],
                      )
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 9.0,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      Image.asset('assets/images/docx.png',
                          width: Get.width * 0.13),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                          translate("MOD_COM", appController.lang),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black87, fontSize: 14),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
<<<<<<< HEAD
                              onPressed: () {
                                _launchURL(
                                    "$baseUrlprotocol/download/model/formulaire_demande_permis.pdf");
                              },
=======
                              onPressed: () {},
>>>>>>> 3b4ef694ec5ccf08fcfe189d1d1845376bdc44d2
                              icon: Icon(Icons.download,
                                  size: 20, color: Colors.black54)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit,
                                  size: 20, color: Colors.black54)),
                        ],
                      ),
                    ]),
                  ),
                ),
              ]),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.qr_code_scanner_outlined),
          elevation: 10,
          backgroundColor: Color(0xffeb3446),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: SimpleDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      title: Text(
                        translate("VERIFICATON_PERMIS", appController.lang),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 25),
                      children: [
                        SizedBox(
                            height: 40,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                showQrCode();
                              },
                              icon: const Icon(Icons.qr_code_scanner_outlined),
                              label: Text(
                                  translate("SCANNER", appController.lang)),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color(0xffeb3446),
                                ),
                              ),
                            )),
                        const Divider(
                          color: Colors.white,
                        ),
                        Text(
                          '--- ${translate("ou", appController.lang)} ---',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black38, fontSize: 14),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        TextField(
                          controller: appController.numPermisController,
                          style: const TextStyle(
                              fontSize: 13, color: Color(0xffeb3446)),
                          decoration: InputDecoration(
                            fillColor: const Color(0xffeb3446),
                            hintText: translate(
                                "NUMERO_DE_PERMIS", appController.lang),
                            prefixIcon: const Icon(Icons.edit_outlined,
                                color: Color(0xffeb3446)),
                            suffixIcon: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                appController.getPermis(appController
                                    .numPermisController.text
                                    .split('/')[0]);
                              },
                              icon: const Icon(Icons.send_rounded,
                                  color: Colors.black38),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Text(
                          '--- ${translate("ou", appController.lang)} ---',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black38, fontSize: 14),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        TextField(
                          focusNode: appController.qRfocus,
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[800]),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: const Color(0xffeb3446),
                            hintText: "QR Code",
                            prefixIcon: const Icon(Icons.image_search_rounded,
                                color: Color(0xffeb3446)),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.send_rounded,
                                  color: Colors.black38),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                          height: 20,
                        ),
                      ],
                    )));
          }),
    );
  }

  void showQrCode() {
    Navigator.of(context).pop();
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 0.35,
          left: MediaQuery.of(context).size.width * 0.05,
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: const Color(0xFFBE0019),
                        borderRadius: 10,
                        borderLength: 30,
                        borderWidth: 10,
                        cutOutSize: 300,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              overlayEntry.remove();
                            },
                            child: const Icon(Icons.close,
                                color: Color(0xFFBE0019)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        );
      },
    );
    Overlay.of(context)!.insert(overlayEntry);
    if (controller != null) controller!.resumeCamera();
  }

  _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!appController.isscanning) {
        appController.getPermis(scanData.code);
        appController.isscanning = true;
      }
      appController.update();
      overlayEntry.remove();
    });
  }
}
