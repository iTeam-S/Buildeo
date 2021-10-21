// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xffeb3446),
              Color(0xff8a0a16),
            ],
          )
        ),
        alignment: Alignment.center,
        // color: Color(0xffeb3446),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.32
                ),
                height: MediaQuery.of(context).size.height * 0.30,
                child: Image.asset('assets/images/logo_b.png')),
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.275
                ),
                child: Shimmer.fromColors(
                    baseColor: const Color(0xffffffff),
                    highlightColor: Color(0xffeb3446),
                    period: Duration(seconds: 2),
                    child: Text(
                      "Buildeo",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "ProductSans",
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}