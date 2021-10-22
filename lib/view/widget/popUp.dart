import 'dart:ui';

import 'package:flutter/material.dart';

class PopUpMotif extends StatelessWidget {
  final _controller = TextEditingController();

  PopUpMotif({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: EdgeInsets.all(10),
          backgroundColor: Colors.white,
          title: Text("Le motif de votre refus"),
          children: [
            Container(
              child: Column(
                children: [
                  TextField(
                    controller: this._controller,
                    maxLines: 5,
                    maxLength: 500,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: '    Motif pas plus 500 caractères',
                      hintText: '   Votre texte ici...',
                    ),
                    onChanged: (text) => setState(() {}),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("Annuler"),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("  Ouvrir  "),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  setState(Null Function() param0) {}
}


/**AlertDialog(
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(
            child: Text(
          'ATTENTION !!',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        )),
        content: Text(
          "Veillez saisir le motif de votre refus",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Annuler"),
              ),
              SizedBox(
                width: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Envoyer"),
              )
            ],
          )
        ],
      ), */