// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

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
                    controller: _controller,
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
                        child: Text("Annuler"),
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
                        child: Text("  Ouvrir  "),
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

class PopDownload extends StatelessWidget {
  PopDownload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: EdgeInsets.all(10),
          backgroundColor: Colors.white,
          title: Text("Sous quel format voulez vous votre permis ?"),
          children: [
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: MaterialButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.qr_code),
                          ),
                          Text("QR code")
                        ],
                      )),
                ),
                Text("-OU-"),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: MaterialButton(
                      onPressed: () {},
                      child: Column(children: [
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Icon(Icons.picture_as_pdf),
                        ),
                        Text("PDF")
                      ])),
                ),
              ],
            ))
          ],
        ));
  }

  setState(Null Function() param0) {}
}
