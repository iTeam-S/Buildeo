// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:buildeo/responsive.dart';
import 'package:buildeo/view/widget/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardValidated extends StatelessWidget {
  const CardValidated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            title: Text(
              "Demande n°011/21/CR-Fdt",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
            subtitle: Row(
              children: <Widget>[
                Icon(Icons.watch_later_outlined, color: Colors.black45),
                Text(" Il y a deux jours",  softWrap: true, overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black45))
              ],
            ),
            trailing: Icon(Icons.check, color: Colors.green, size: 30.0)),
      ),
    );
  }
}
