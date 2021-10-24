import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadController extends GetxController {
  double uploadPourcent = 0.0;
  String filepath = '';
  TextEditingController filename = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController commmune = TextEditingController();
  late String type;

  FocusNode focus = FocusNode();



}