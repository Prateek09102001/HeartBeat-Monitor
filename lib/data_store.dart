import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataStore extends StatefulWidget {
  const DataStore({super.key});

  @override
  State<DataStore> createState() => _DataStoreState();
}

class _DataStoreState extends State<DataStore> {

  final CollectionReference _table = FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
