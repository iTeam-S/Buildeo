import 'package:flutter/material.dart';

class CoolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Loop',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: CoolAppPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CoolAppPage extends StatefulWidget {
  @override
  _CoolAppPageState createState() => _CoolAppPageState();
}

class _CoolAppPageState extends State<CoolAppPage> {
  List amplifiers = <String>["+cekah", "+CO2"];
  List ampExp = <String>["+dom", "+reg"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: amplifiers.length,
        itemBuilder: (BuildContext context, int position) {
          return getRow(position);
        });
  }

  Widget getRow(int i) {
    return GestureDetector(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Colors.orange,
          elevation: 10,
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(10.0),
              leading: Icon(
                Icons.refresh,
                size: 70,
                color: Colors.orange[900],
              ),
              title: Text(
                amplifiers[i],
                style: TextStyle(letterSpacing: 3.0),
              ),
              subtitle: Text(ampExp[i]),
            ),
          ]),
        ),
        onTap: () {
          setState(() {});
        });
  }
}
