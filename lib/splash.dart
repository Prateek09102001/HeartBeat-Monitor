import 'package:flutter/material.dart';
import 'package:health_monitoring_app/screen/login.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';


class SplashApp extends StatelessWidget {
  const SplashApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
   const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10)).then((value) => setState(() {
      isLoaded = true;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateWhere: isLoaded,
      navigateRoute: const Login(), backgroundColor: Colors.white,
      linearGradient: const LinearGradient(
          colors: [
            Color(0xFF3366FF),
            Color(0xFF00CCFF),
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
      text: WavyAnimatedText(
        "Health Monitor",
        textStyle: const TextStyle(
          color: Colors.red,
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      imageSrc: "https://media.giphy.com/media/3TUzR4m7XlW6AwXK54/giphy.gif",
      //  displayLoading: false,
    );
  }
}