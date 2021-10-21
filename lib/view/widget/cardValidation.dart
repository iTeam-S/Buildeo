import 'package:buildeo/view/widget/popUp.dart';
import 'package:flutter/material.dart';

class CardValidated extends StatelessWidget {
  const CardValidated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.red.shade900,
            borderRadius: BorderRadius.circular(20)),
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
                      color: Colors.white,
                      size: 30,
                    ))),
            title: Text(
              "Demande de construire\nn°011/21/CR-Fdt",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Row(
              children: <Widget>[
                Icon(Icons.watch_later_outlined, color: Colors.white),
                Text(" Il y a deux jours",
                    style: TextStyle(color: Colors.white))
              ],
            ),
            trailing:
                Icon(Icons.check_box_rounded, color: Colors.white, size: 30.0)),
      ),
    );
  }
}
