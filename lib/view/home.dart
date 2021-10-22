import 'dart:io';
import 'package:buildeo/controller/app.dart';
import 'package:buildeo/translate.dart';
import 'package:buildeo/view/widget/drawer.dart';
import 'package:file_picker/file_picker.dart';

//import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

  void onFocusChange() {
    debugPrint("Focus: " + appController.qRfocus.hasFocus.toString());
    if (appController.qRfocus.hasFocus) _openFileExplorer();
  }

  @override
  void initState() {
    super.initState();
    appController.qRfocus.addListener(onFocusChange);
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
        print("Annuler");
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  AppDrawer drawer = AppDrawer();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: drawer,
      body: Container(
        alignment: Alignment.center,
        color: const Color(0xfffefefe),
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
                                  //Get.to(AppDrawer());
                                  _key.currentState!.openDrawer();
                                },
                                icon: const Icon(Icons.sort, color: Colors.white),
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
                            top: MediaQuery.of(context).size.height * 0.04,
                          ),
                          child: Text(
                              translate(
                                  "DEMANDER_ET_RECEVER", appController.lang),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 14.5, color: Colors.white))),
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
                            Get.to('/confirm_pass');
                          },
                          valueColor: Colors.white,
                          borderRadius: 90,
                          child: Text(translate("DEMANDER", appController.lang),
                              style: const TextStyle(color: Colors.white)),
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
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.qr_code_scanner_outlined),elevation: 10, backgroundColor: Color(0xffeb3446), onPressed: (){
       showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text(
                translate("VERIFICATON_PERMIS", appController.lang), textAlign: TextAlign.center, style: const TextStyle(fontSize: 18),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              children: [
                SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: (){showQrCode();}, icon: const Icon(Icons.qr_code_scanner_outlined), label: Text(translate("SCANNER", appController.lang)), style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Color(0xffeb3446), ),),
                    )
                ),
                const Divider(color: Colors.white,),
                Text('--- ${translate("ou", appController.lang)} ---',textAlign: TextAlign.center, style: TextStyle(color: Colors.black38, fontSize: 14),),
                const Divider(color: Colors.white,),
                TextField(
                    controller: appController.numPermisController,
                  style: const TextStyle(fontSize: 13, color:  Color(0xffeb3446)),
                  decoration: InputDecoration(
                    fillColor:  const Color(0xffeb3446),
                    hintText: translate("NUMERO_DE_PERMIS", appController.lang),
                    prefixIcon: const Icon(Icons.edit_outlined, color:  Color(0xffeb3446)),
                    suffixIcon: IconButton(onPressed: (){
                          Navigator.of(context).pop();
                      appController.getPermis( appController.numPermisController.text.split('/')[0] );
                    }, icon: const Icon(Icons.send_rounded, color:  Colors.black38),),
                  ),
                ),
                    const Divider(color: Colors.white,),
                    Text('--- ${translate("ou", appController.lang)} ---',textAlign: TextAlign.center, style: TextStyle(color: Colors.black38, fontSize: 14),),
                    const Divider(color: Colors.white,),
                TextField(
                  focusNode: appController.qRfocus,
                  style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                  keyboardType: TextInputType.none,
                 decoration: InputDecoration(
                    fillColor:  const Color(0xffeb3446),
                    hintText: "QR Code",
                    prefixIcon: const Icon(Icons.image_search_rounded, color:  Color(0xffeb3446)),
                    suffixIcon: IconButton(onPressed: (){
                  
                    }, icon: const Icon(Icons.send_rounded, color:  Colors.black38),),
                  ),
                ),
                 const Divider(color: Colors.white, height: 20,),
              ],
            ));
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
                            child: const Icon(Icons.close, color: Color(0xFFBE0019)),
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
