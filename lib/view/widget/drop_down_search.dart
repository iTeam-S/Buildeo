// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:substring_highlight/substring_highlight.dart';

class Dropdowncommune extends StatefulWidget {
  const Dropdowncommune({Key? key}) : super(key: key);
  @override
  _DropdowncommuneState createState() => _DropdowncommuneState();
}

class _DropdowncommuneState extends State<Dropdowncommune> {
  bool isLoading = false;

  late List<String> autoCompleteData;

  late TextEditingController controller;

  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    final List<dynamic> json = [
      "Tanjombato",
      "Ambatoroka",
      "Andoharanofotsy",
      "Analakely",
      "Antanimena",
      "Tananarive",
      "Bonditsiry",
    ];

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
                    term: controller.text,
                    textStyleHighlight: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text("This is subtitle"),
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
          this.controller = controller;

          return TextField(
            controller: controller,
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
