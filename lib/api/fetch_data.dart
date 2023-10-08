import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_monitoring_app/screen/register.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:unique_simple_bar_chart/data_models.dart';
import 'package:unique_simple_bar_chart/simple_bar_chart.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}
class _FetchDataState extends State<FetchData> {
  Register r =Register();
  Tester t = Tester();
  final CollectionReference _table = FirebaseFirestore.instance.collection('users');
 //upload api data into cloud
 //  Future uploadData() async {
 //    try {
 //        await _table.add(t.item1);
 //        await _table.add(t.item2);
 //    } catch (e) {
 //      print("Error: $e");
 //    }
 //  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent.shade200,
        title: Text(""),
      ),
      backgroundColor: Colors.black12,
      body: ChangeNotifierProvider<Tester>(
      create: (context) => Tester(),
        child: Consumer<Tester>(
        builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60,),
              Text("HeartBeat: ${provider.item1.toString()}",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline
              ),),
              SizedBox(height: 30,),
              Text("SPO2: ${provider.item2.toString()}",
              style: const TextStyle(
                color: Colors.orangeAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline
              ),),
              Center(
                  child:  SimpleBarChart(
                    makeItDouble: true,

                    listOfHorizontalBarData: [
                      if(provider.getDayName(1)=="monday")
                      HorizontalDetailsModel(
                        name: 'Monday',
                        color: Colors.red,
                        size: provider.getDayName(6) == "Saturday" ? double.parse(provider.item1 ?? "0") : 0.0,
                        sizeTwo: provider.getDayName(6) == "Saturday" ? double.parse(provider.item2 ?? "0") : 0.0,
                        colorTwo: Colors.orangeAccent,
                      ),
                      if(provider.getDayName(2)=="tuesday")
                      HorizontalDetailsModel(
                        name: 'Tuesday',
                        color: Colors.red,
                        size: provider.getDayName(6) == "Saturday" ? double.parse(provider.item1 ?? "0") : 0.0,
                        sizeTwo: provider.getDayName(6) == "Saturday" ? double.parse(provider.item2 ?? "0") : 0.0,
                        colorTwo: Colors.orangeAccent,
                      ),
                      if(provider.getDayName(3)=="wednesday")
                      HorizontalDetailsModel(
                        name: 'Wednesday',
                        color: Colors.red,
                        size: provider.getDayName(6) == "Saturday" ? double.parse(provider.item1 ?? "0") : 0.0,
                        sizeTwo: provider.getDayName(6) == "Saturday" ? double.parse(provider.item2 ?? "0") : 0.0,
                        colorTwo: Colors.orangeAccent,
                      ),
                      if(provider.getDayName(4)=="thursday")
                      HorizontalDetailsModel(
                        name: 'Thursday',
                        color: Colors.red,
                        size: provider.getDayName(6) == "Saturday" ? double.parse(provider.item1 ?? "0") : 0.0,
                        sizeTwo: provider.getDayName(6) == "Saturday" ? double.parse(provider.item2 ?? "0") : 0.0,
                        colorTwo: Colors.orangeAccent,
                      ),
                      if(provider.getDayName(5)=="friday")
                      HorizontalDetailsModel(
                        name: 'Friday',
                        color: Colors.red,
                        size: provider.getDayName(6) == "Saturday" ? double.parse(provider.item1 ?? "0") : 0.0,
                        sizeTwo: provider.getDayName(6) == "Saturday" ? double.parse(provider.item2 ?? "0") : 0.0,
                        colorTwo: Colors.orangeAccent,
                      ),

                      HorizontalDetailsModel(
                        name: 'Saturday',
                        color: Colors.red,
                        size: provider.getDayName(6) == "Saturday" ? double.parse(provider.item1 ?? "0") : 0.0,
                        sizeTwo: provider.getDayName(6) == "Saturday" ? double.parse(provider.item2 ?? "0") : 0.0,
                        colorTwo: Colors.orangeAccent,
                      ),
                      if(provider.getDayName(7)=="sunday")
                      HorizontalDetailsModel(
                        name: 'Sunday',
                        color: Colors.red,
                        size: provider.getDayName(6) == "Saturday" ? double.parse(provider.item1 ?? "0") : 0.0,
                        sizeTwo: provider.getDayName(6) == "Saturday" ? double.parse(provider.item2 ?? "0") : 0.0,
                        colorTwo: Colors.orangeAccent,
                      ),
                    ],
                    verticalInterval: 50,
                    horizontalBarPadding: 20,
                    fullBarChartHeight: 300,
                  ),

              ),
              const SizedBox(height: 40,),
              ElevatedButton(
                  onPressed: (){
                    String docId;
                    provider.getInfo();
                    // int? HeartBeat = int.parse(provider.item1.text);
                    // int? SPO2 = int.parse(provider.item2.text);
                    _create(docId)async{{
                    await _table.doc(docId).set({
                    "HeartRate": provider.item1,
                    "SPO2": provider.item2,
                    });
                    }}
                    _update(String docId)async{
                    _table.doc(docId).update({"HeartRate": provider.item1,"SPO2": provider.item2});}
                  },
                  child: const Text("Check"))
            ],
          ),
        );
      }),
      ),

    );
  }
}

class Tester extends ChangeNotifier{

var item1;
var item2;

  Tester()
  {
    Stream.periodic(const Duration(minutes: 30)).listen((_) {
      Future<dynamic>.delayed(const Duration(seconds: 10),(){
        return getInfo();
      });
    });
  }
getInfo()async
{
  var rawData = await http.get(
      Uri.parse('https://api.thingspeak.com/channels/875453/feeds.json?api_key=1DSQ7R1XTT1OK0Z1&results=1'));
  var data = jsonDecode(rawData.body.toString());
  print(rawData);
  item1 = data['feeds'][0]['field1'];
  item2 = data['feeds'][0]['field2'];
  print(item1);
  print(item2);
  notifyListeners();
}

day() {
  DateTime now = DateTime.now();
  int dayOfWeek = now.weekday;
  String dayName = getDayName(dayOfWeek);
}

String getDayName(int dayOfWeek) {
  switch (dayOfWeek) {
    case DateTime.monday:
      return 'Monday';
    case DateTime.tuesday:
      return 'Tuesday';
    case DateTime.wednesday:
      return 'Wednesday';
    case DateTime.thursday:
      return 'Thursday';
    case DateTime.friday:
      return 'Friday';
    case DateTime.saturday:
      return 'Saturday';
    case DateTime.sunday:
      return 'Sunday';
    default:
      return 'Invalid Day';
  }
}
}
