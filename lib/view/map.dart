// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:city_picker_from_map/city_picker_from_map.dart';
import 'package:get/get.dart';
import 'package:buildeo/view/widget/drawer.dart';

class CarteView extends StatefulWidget {
  @override
  _CarteView createState() => _CarteView();
  const CarteView({Key? key}) : super(key: key);
}

class _CarteView extends State<CarteView> {
  City? selectedCity;
  final GlobalKey<CityPickerMapState> _mapKey = GlobalKey();

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  AppDrawer drawer = AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: drawer,
      appBar: AppBar(
        leading: IconButton( onPressed: () {
          //Get.to(AppDrawer());
          _key.currentState!.openDrawer();
          },
          icon: const Icon(Icons.sort, color: Colors.white),
        ),
        title: Text('Region selctionnée : ${selectedCity?.title ?? 'Pas de région'}', style: TextStyle(fontSize: 15),),
        backgroundColor: Color(0xffeb3446),
        elevation: 5,
        actions: [
          IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                _mapKey.currentState?.clearSelect();
                setState(() {
                  selectedCity = null;
                });
              })
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: InteractiveViewer(
              scaleEnabled: true,
              panEnabled: true,
              constrained: true,
              child: CityPickerMap(
                key: _mapKey,
                width: double.infinity,
                height: double.infinity,
                map: Maps.MADAGASCAR,
                onChanged: (city) {
                  setState(() {
                    selectedCity = city;
                  });
                  Get.snackbar('Redirection',
                      'Recherche pour la région de ${selectedCity?.title.toString()}');
                },
                actAsToggle: true,
                dotColor: Colors.white,
                selectedColor: Colors.teal,
                strokeColor: Colors.teal[600],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
