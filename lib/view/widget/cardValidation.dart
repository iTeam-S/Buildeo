import 'package:buildeo/responsive.dart';
import 'package:buildeo/view/widget/popUp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardValidated extends StatelessWidget {
  const CardValidated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 10.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        height: isMobile(context)
            ? Get.height * 0.15
            : 500 /*la taille ne s'applique pas à isDesktop */,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
        child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white24))),
                child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return PopUpMotif();
                          });
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red.shade400,
                      size: 30,
                    ))),
            title: Text(
              "Demande n°011/21/CR-Fdt",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
            subtitle: Row(
              children: <Widget>[
                Icon(Icons.watch_later_outlined, color: Colors.black45),
                Text(" Il y a deux jours",
                    style: TextStyle(color: Colors.black45))
              ],
            ),
            trailing: Icon(Icons.check_box_outline_blank_rounded,
                color: Colors.black45, size: 30.0)),
      ),
    );
  }
}
