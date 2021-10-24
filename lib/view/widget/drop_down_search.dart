// ignore_for_file: prefer_const_constructors

import 'package:buildeo/controller/app.dart';
import 'package:buildeo/controller/upload.dart';
import 'package:buildeo/model/commune.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:substring_highlight/substring_highlight.dart';

final AppController appController = Get.put(AppController());
final UploadController uploadController = Get.put(UploadController());

class Dropdowncommune extends StatefulWidget {
  const Dropdowncommune({Key? key}) : super(key: key);
  @override
  _DropdowncommuneState createState() => _DropdowncommuneState();
}

class _DropdowncommuneState extends State<Dropdowncommune> {
  bool isLoading = false;

  late List<String> autoCompleteData;

  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    List<String> tmp = []; 
    for (Commune com in appController.communes){
      tmp.add(com.nom);
    }
    final List<dynamic> json = tmp;

    final List<String> jsonStringData = json.cast<String>();

    setState(() {
      isLoading = false;
      autoCompleteData = jsonStringData;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAutoCompleteData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Autocomplete(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          } else {
            return autoCompleteData.where((word) => word
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()));
          }
        },
        optionsViewBuilder: (context, Function(String) onSelected, options) {
          return Material(
            elevation: 4,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final option = options.elementAt(index);

                return ListTile(
                  // title: Text(option.toString()),
                  title: SubstringHighlight(
                    text: option.toString(),
                    term: uploadController.commmune.text,
                    textStyleHighlight: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text("Commune"),
                  onTap: () {
                    onSelected(option.toString());
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: options.length,
            ),
          );
        },
        onSelected: (selectedString) {
          print(selectedString);
        },
        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
          uploadController.commmune = controller;

          return TextField(
            controller: uploadController.commmune,
            focusNode: focusNode,
            onEditingComplete: onEditingComplete,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.teal[60],
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none),
              focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide.none),
              hintText: ('Commune'),
              prefixIcon: Icon(Icons.holiday_village, color: Color(0xffeb3446)),
            ),
          );
        },
      )
    ]);
  }
}
