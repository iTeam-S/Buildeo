import 'package:buildeo/view/widget/cardValidation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

late final height, widht;

class ValidationMaire extends StatelessWidget {
  const ValidationMaire({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 0.6 * height,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.1 * width),
                    bottomRight: Radius.circular(0.1 * width)),
              ),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 30,
                              )),
                        ),
                        SizedBox(width: 0.7 * width),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.grading_outlined,
                                color: Colors.white,
                                size: 30,
                              )),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Vos validations en attente ...",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0.03 * height,
            ),
            CardValidated()
          ],
        ),
      ),
    );
  }
}
