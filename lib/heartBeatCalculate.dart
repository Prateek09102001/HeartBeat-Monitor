import 'package:flutter/material.dart';
import 'package:heart_bpm/heart_bpm.dart';


class HeartRate extends StatelessWidget {
  const HeartRate({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BPM(),
    );
  }
}

class BPM extends StatefulWidget {
  const BPM({super.key});

  @override
  State<BPM> createState() => _BPM();
}

class _BPMState extends State<BPM> {
  /// list to store raw values in
  List<SensorValue> data = [];
  int? bpmValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Cover both flash and camera with your finger',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
             Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.favorite_rounded,
                size: 88,
                color: Colors.red,),
                HeartBPMDialog(
                  context: context,
                  onRawData: (value) {
                    setState(() {
                      // add raw data points to the list
                      // with a maximum length of 100

                      if (data.length == 100) {
                        data.removeAt(0);
                      }
                      data.add(value);
                    });
                  },
                  onBPM: (value) => setState(() {
                    bpmValue = value;
                  }),
                  child: Text(
                      bpmValue.toString()??"_",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),textAlign: TextAlign.center
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }