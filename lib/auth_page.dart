import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_monitoring_app/api/fetch_data.dart';
import 'package:health_monitoring_app/screen/login.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot)
          {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            else{
              if(snapshot.hasData){
                return const FetchData();
              }else{
                return const Login();
              }
            }
          }
      ),
    );
  }
}
