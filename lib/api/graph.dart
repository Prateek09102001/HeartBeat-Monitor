import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'fetch_data.dart';
const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class Graph extends StatelessWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Health Monitor"),
        ),
        body: MyScreen(),
      ),
    );
  }
}

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  static List<Feature> feature() {
    FetchData obj1 = const FetchData();
    Tester obj = Tester();
    double data1 = obj.item1 ?? 0.0;
    double data2 = obj.item2 ?? 0.0;

    return [
      Feature(
        title: "HeartBeat",
        color: Colors.blue,
        data: [data1],
      ),
      Feature(
        title: "SPO2",
        color: Colors.pink,
        data: [data2],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(),
       const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          LineGraph(

            features: feature(),
            size: const Size(320, 500),
            labelX: const ['00:00', '06:00', '12:00', '18:00', '24:00'],
            labelY: const ['1', '2', '3', '4', '5'],
            showDescription: true,
            graphColor: Colors.white30,
            graphOpacity: 0.2,
            verticalFeatureDirection: true,
            descriptionHeight: 130,
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}