import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This is the stateless widget that the main application instantiates.
class UserID extends StatelessWidget {
  const UserID({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Get.height * 0.16,
        child: Card(
          color: Colors.transparent,
          elevation: 10,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                const ListTile(
                  leading: CircleAvatar(
                    radius: 35,
                    backgroundImage: ExactAssetImage("assets/images/user.png"),
                  ),
                  title: Text('Gaetan Jonathan Bakary'),
                  subtitle:
                      Text('CIN: 03535244665524\nAdresse: Mangarano Nord'),
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
      ),
    );
  }
}
