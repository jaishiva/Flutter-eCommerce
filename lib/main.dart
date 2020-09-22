import 'package:e_commerce/screens/frontpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
  
  FirebaseFirestore _fireStore;
  @override
  void initState() {
    super.initState();
    
    getItemsData();
  }

  void getItemsData() async{
     await Firebase.initializeApp();
    _fireStore = FirebaseFirestore.instance;
    chairListData = await _fireStore.collection('chairs').get();
    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [
                ChangeNotifierProvider(create: (context) => Data(),),
                ChangeNotifierProvider(create: (context) => SpinnerProvider(),)
              ],
              child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: showSpinner? Container():Frontpage()
          ),
      ),
    );
  }
}
