// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:health_monitoring_app/api/fetch_data.dart';
import 'package:health_monitoring_app/api/graph.dart';
import 'package:health_monitoring_app/auth_page.dart';
import 'package:health_monitoring_app/main.dart';
import 'package:health_monitoring_app/screen/login.dart';

class Register extends StatefulWidget {
 const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final db = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController Name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Contact = TextEditingController();
  TextEditingController Age = TextEditingController();
  TextEditingController Heigth = TextEditingController();
  TextEditingController Weight = TextEditingController();
  TextEditingController Gender = TextEditingController();
  TextEditingController Password = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  Future<void> createAccount(
      String Email, String Password,
      String Name,String Height,
      String Weight, String Age,
      String Contact) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email,
        password: Password,
      );

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'name': Name,
        'email': Email,
        'contact': Contact,
        'age': Age,
        'height': Height,
        'weight': Weight,
        'password': Password,
        // Add more fields as needed
      });
      _scaffoldKey.currentState?.showSnackBar(const SnackBar(
        content: Text('Registration successful!'),
        duration: Duration(seconds: 2),
      ));
      print('User registered and data stored in Firestore');
      navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (context) => const Login()),);
        const AuthPage();
        db.collection("users").add(userCredential.user as Map<String, dynamic>).then((DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));

    } catch (error) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text('Error: $error'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
      print('Error: $error');
    }
  }

  @override
  void dispose() {
    Name.dispose();
    Email.dispose();
    Contact.dispose();
    Age.dispose();
    Heigth.dispose();
    Weight.dispose();
    Gender.dispose();
    Password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Monitor"),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      backgroundColor: Colors.white,
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
                    const Text(
                      "Register Page",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: Name,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",
                        hintText: "Enter User Name",
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: Email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter User Email Address",
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: Contact,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        hintText: "Enter User Number",
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: Age,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Age",
                        hintText: "Enter User Age",
                        prefixIcon: const Icon(Icons.leaderboard),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: Heigth,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Height",
                        hintText: "Enter User Height(in inch)",
                        prefixIcon: const Icon(Icons.height),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: Weight,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Weight",
                        hintText: "Enter User Weight(in KG)",
                        prefixIcon: const Icon(Icons.monitor_weight_outlined),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: Password,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter User Password",
                        prefixIcon: const Icon(Icons.password_sharp),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // _buildButton(),
                    ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          createAccount(Email.text,
                              Password.text,
                              Name.text,
                              Heigth.text,
                              Weight.text,
                              Age.text,
                              Contact.text);
                        }

                      },style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent.shade100, // Background color
                      onPrimary: Colors.white, // Text color
                      elevation: 10, // Elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                    ),child: isLoading
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                        : const Text("Register"),),
                    const SizedBox(
                      height: 30,
                    ),

                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: "Already have an Account?",
                          style: TextStyle(color: Colors.grey)),
                      const WidgetSpan(
                          child: SizedBox(
                        width: 5,
                      )),
                      TextSpan(
                          text: "Login here",
                          style: const TextStyle(color: Colors.black),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            })
                    ])),
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


