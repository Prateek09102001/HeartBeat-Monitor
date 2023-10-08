import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:health_monitoring_app/api/fetch_data.dart';
import 'package:health_monitoring_app/screen/login.dart';
import 'package:health_monitoring_app/screen/register.dart';
import 'package:health_monitoring_app/splash.dart';
import 'package:provider/provider.dart';


GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SplashApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Register(),
    );
  }
}
