import 'package:flutter/material.dart';
import 'package:health_monitoring_app/api/fetch_data.dart';
import 'package:unique_simple_bar_chart/data_models.dart';
import 'package:unique_simple_bar_chart/horizontal_bar.dart';
import 'package:unique_simple_bar_chart/horizontal_line.dart';
import 'package:unique_simple_bar_chart/simple_bar_chart.dart';

class BarChart extends StatelessWidget {
  BarChart({super.key});
  Tester obj = Tester();

  // static access(){
  //   Tester obj = Tester();
  //   print("HeartBeat: $obj.item1");
  //   double data1 = obj.item1 ?? 0.0;
  //   return data1;}
  //
  // static access1(){
  //   Tester obj = Tester();
  //   // print("SPO2:$obj.item2");
  //   double data2 = obj.item2 ?? 0.0;
  //   return data2;}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child:  SimpleBarChart(
          makeItDouble: true,
          listOfHorizontalBarData: [
            HorizontalDetailsModel(
              name: 'Mon',
              color: const Color(0xFFEB7735),
              size: obj.item1,
              sizeTwo: obj.item2,
              colorTwo: Colors.blue,
            ),
            HorizontalDetailsModel(
              name: 'Tues',
              color: const Color(0xFFEB7735),
              size: obj.item1,
              sizeTwo: obj.item2,
              colorTwo: Colors.blue,
            ),
            HorizontalDetailsModel(
              name: 'Wed',
              color: const Color(0xFFFBBC05),
              size: obj.item1,
              sizeTwo: obj.item2,
              colorTwo: Colors.blue,
            ),
            HorizontalDetailsModel(
              name: 'Thurs',
              color: const Color(0xFFFBBC05),
              size: obj.item1,
              sizeTwo: obj.item2,
              colorTwo: Colors.blue,
            ),
            HorizontalDetailsModel(
              name: 'Fri',
              color: const Color(0xFFFBBC05),
              size: obj.item1,
              sizeTwo: obj.item2,
              colorTwo: Colors.blue,
            ),
            HorizontalDetailsModel(
              name: 'Sat',
              color: const Color(0xFFFBBC05),
              size: obj.item1,
              sizeTwo: obj.item2,
              colorTwo: Colors.blue,
            ),
            HorizontalDetailsModel(
              name: 'Sun',
              color: const Color(0xFFFBBC05),
              size: obj.item1,
              sizeTwo: obj.item2,
              colorTwo: Colors.blue,
            ),
          ],
          verticalInterval: 1,
          horizontalBarPadding: 20,
          fullBarChartHeight: 500,
        ),

      ),
    );
  }
}
