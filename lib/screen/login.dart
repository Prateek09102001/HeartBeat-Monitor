import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:health_monitoring_app/api/fetch_data.dart';
import 'package:health_monitoring_app/api/graph.dart';
import 'package:health_monitoring_app/auth_page.dart';
import 'package:health_monitoring_app/bar_chart.dart';
import 'package:health_monitoring_app/main.dart';
import 'package:health_monitoring_app/screen/register.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
 const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  bool isLoading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController Email = TextEditingController();
  TextEditingController Password =  TextEditingController();
  void loginUser(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _scaffoldKey.currentState?.showSnackBar(const SnackBar(
        content: Text('Login successful!'),
        duration: Duration(seconds: 2),
      ));
      // If login is successful, navigate to the home page
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => const FetchData()),
      );

    } catch (e) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text('Error: $e'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
      print("Error: $e");
      // Handle login error here (show error message, etc.)
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Monitor"),
        backgroundColor: Colors.blueAccent.shade100,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Container(
            width: 300,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Login Page",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),),
                    SizedBox(height: 30,),
                          TextField(
                        controller: Email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter User Email Address",
                        prefixIcon: const Icon(Icons.email),
                        iconColor: Colors.black,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                            onChanged: (value) => print(value),
                      ),const SizedBox(height: 30,),
                    TextField(
                          controller: Password,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter User Password",
                            prefixIcon: const Icon(Icons.lock),
                            iconColor: Colors.black,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),

                          ),
                          onChanged: (value) => print(value),
                        ),const SizedBox(height: 30,),
                    ElevatedButton(onPressed: () async {
                     if(_formkey.currentState!.validate())
                       {
                         loginUser(Email.text, Password.text, context);
                       }

                    },child: Container(
                          height: 45,
                          width: 120,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text("Login",
                          style: TextStyle(color: Colors.white,fontSize: 25),),
                        ),
                    ),
                    // _buildButton(),
                    const SizedBox(height: 30,),
                    RichText(text:  TextSpan(
                      children: [
                        const TextSpan(
                            text: "Need an Account?",
                            style: TextStyle(color: Colors.grey)
                        ),
                        const WidgetSpan(child: SizedBox(width: 5,)),
                        TextSpan(
                          text: "Register here",
                            style: const TextStyle(color: Colors.black),
                          recognizer: TapGestureRecognizer()  ..onTap = (){
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => Register()));
                          }

                        )
                      ]
                    )

                    ),
                    // const Text("Need an Account? Register here",)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
