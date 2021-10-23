import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserID extends StatefulWidget {
  const UserID({Key? key}) : super(key: key);

  @override
  _UserIDState createState() => _UserIDState();
}

class _UserIDState extends State<UserID> {
  List<String> names = [
    "Gaetan Jonathan",
    "Landry BAKARY",
    "Arlème Johnson",
    "Dominick Randria",
    "Rakoharisoa Alin",
    "James Bond",
    "Cherlok Holmes",
    "Razafy rasoa",
    "Herisoa Nantenaina",
    "Harinohony Ramanandraibe"
  ];
  List<String> CIN = [
    "01478520369",
    "12345697890",
    "98748563210",
    "09874651230",
    "01255055479",
    "56488200368",
    "97885421315",
    "28486611133",
    "84452224448",
    "28189878945"
  ];
  List<String> adresses = [
    "Tanjombato",
    "Ambatoroka",
    "Andoharanofotsy",
    "Analakely",
    "Antanimena",
    "Tananarive",
    "Bonditsiry",
    "Sampanana",
    "Andraharo",
    "Mananara Nord"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: names.length,
        itemBuilder: (BuildContext, index) {
          return Container(
            height: Get.height * 0.18,
            child: Card(
              color: Colors.transparent,
              elevation: 10,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundImage:
                            ExactAssetImage("assets/images/user.png"),
                      ),
                      title: Text(names[index].toString()),
                      subtitle: Text(
                          'CIN:' + CIN[index] + '\nAdresse:' + adresses[index]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('VOIR PERMIS'),
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: 19,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
/** */




                        /**
                         * 
                         * 
                         * 
                         */