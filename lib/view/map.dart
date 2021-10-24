// ignore_for_file: prefer_const_constructors
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
//import 'package:buildeo/view/widget/pop_up.dart';
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
        leading: IconButton(
          onPressed: () {
            //Get.to(AppDrawer());
            _key.currentState!.openDrawer();
          },
          icon: const Icon(Icons.sort, color: Colors.white),
        ),
        title: Text(
          'Region selctionnée : ${selectedCity?.title ?? 'Pas de région'}',
          style: TextStyle(fontSize: 15),
        ),
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
              }),
          IconButton(
              icon: Icon(Icons.home_filled, color: Colors.white),
              onPressed: () {
                Get.toNamed('/home');
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
                    showDialog(
                        context: context,
                        barrierColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return PopUpStat(
                              region: selectedCity!.title.toString());
                        });
                  },
                  actAsToggle: true,
                  dotColor: Colors.white,
                  selectedColor: Color(0xffeb3446),
                  strokeColor: Color(0xffeb3446)),
            ),
          ),
        ),
      ),
    );
  }
}

class PopUpStat extends StatefulWidget {
  final String region;
  PopUpStat({Key? key, required this.region}) : super(key: key);

  @override
  _PopUpStatState createState() => _PopUpStatState();
}

class _PopUpStatState extends State<PopUpStat> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  late String region;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: EdgeInsets.all(10),
          backgroundColor: Color(0xff232d37),
          title: Text(
            "Statistique des demandes à " + widget.region,
            style: TextStyle(color: Colors.white),
          ),
          children: [LineChartSample2()],
        ));
  }
}

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({Key? key}) : super(key: key);

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xFFEB5E5E),
    const Color(0xFFF13232),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(0xff232d37)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'demandes',
              style: TextStyle(
                  fontSize: 12,
                  color:
                      showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 5:
                return 'OCT';
              case 8:
                return 'NOV';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10';
              case 3:
                return '20';
              case 5:
                return '30';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 0),
            FlSpot(2.6, 1),
            FlSpot(3, 1),
            FlSpot(4, 1),
            FlSpot(6, 1),
            FlSpot(9, 5),
            FlSpot(10, 6),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
