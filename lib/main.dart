import 'package:e_commerce/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:e_commerce/model/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showSpinner = true;
  final Firestore _firestore = Firestore.instance;
  @override
  void initState() {
    super.initState();
    getItemsData();
  }

  void getItemsData() async{
    chairListData = await _firestore.collection('chairs').getDocuments();
    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: showSpinner? Container():HomePage()
      ),
    );
  }
}
