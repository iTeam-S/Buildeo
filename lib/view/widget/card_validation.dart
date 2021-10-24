// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:buildeo/model/permis.dart';
import 'package:buildeo/view/widget/card_permis.dart';
import 'package:flutter/material.dart';


  Widget cardValidated(Permis perm) {
    return Card(
        color: Colors.transparent,
        elevation: 0.0,
        margin: EdgeInsets.only(left: 10.0, right: 10.0,  top: 10, bottom: 6.0),
        child: Container(
          height: 90,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 9.0,
              offset: Offset(0, 3),
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              title: Text(
                "Demande n°${perm.id}",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
              subtitle: Row(
                children: <Widget>[
                  Icon(Icons.watch_later_outlined, color: Colors.black45),
                  Text(perm.reqDate,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black45))
                ],
              ),
              trailing: CircleAvatar(
                  radius: 14,
                  backgroundColor: Color(0xff2ebc4f),
                  child: IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 13,
                    ),
                    onPressed: () {
                      appController.updateStatus('VALIDE', '', perm.id);
                    },
                  ))),
        ));
  }

