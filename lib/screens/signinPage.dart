import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  double elevation = 5.0;

  double height1 = 44;

  double height2 = 44;

  String email;

  String password;
  bool spinner = false;
  final _auth = FirebaseAuth.instance;
  final _fireStore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: spinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Expanded(
                child: Image.asset(
              'assets/table.png',
            )),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    onChanged: (value) => email = value,
                    decoration:
                        textDecoration(hint: 'email').textFieldDecoration(),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) => password = value,
                    decoration:
                        textDecoration(hint: 'password').textFieldDecoration(),
                    textAlign: TextAlign.center,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: MaterialButton(
                            color: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            enableFeedback: true,
                            elevation: elevation,
                            height: height1,
                            animationDuration: Duration(seconds: 1),
                            child: Text('Login'),
                            onPressed: () async {
                              setState(() {
                                spinner = true;
                                height1 = 50;
                                height2 = 44;
                              });
                              try {
                                loggedInUser = await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                                    print(loggedInUser.user);
                               cart = await _fireStore.collection(email).document('cart').collection('0').getDocuments();
                               favorite = await _fireStore.collection(email).document('favorite').collection('0').getDocuments();
                                setState(() {
                                  spinner = false;
                                });
                                await showCupertinoModalPopup(
                                    semanticsDismissible: true,
                                    context: context,
                                    builder: (context) {
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pop();
                                      });
                                      return CupertinoAlertDialog(
                                        title: Text('Success'),
                                        content:
                                            Text('User Log in successfully'),
                                      );
                                    });
                                Navigator.pop(context);
                              } catch (e) {
                                await showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    Future.delayed(Duration(seconds: 2), () {
                                      Navigator.of(context).pop();
                                    });
                                    return CupertinoAlertDialog(
                                      title: Text('Error'),
                                      content: Text(e.message),
                                    );
                                  },
                                );
                                setState(() {
                                  spinner = false;
                                });
                              }
                            }),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: MaterialButton(
                            color: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            enableFeedback: true,
                            elevation: elevation,
                            height: height2,
                            animationDuration: Duration(seconds: 1),
                            child: Text('Register'),
                            onPressed: () async {
                              setState(() {
                                spinner = true;
                                height1 = 44;
                                height2 = 50;
                              });
                              try {
                               loggedInUser =  await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                              _fireStore.collection(email).document('cart').setData({});
                              _fireStore.collection(email).document('favorite').setData({});
                                await showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) {
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pop(true);
                                      });
                                      return CupertinoAlertDialog(
                                        title: Text('Success'),
                                        content: Text(
                                          'User registered successfully',
                                        ),
                                      );
                                    });
                                Navigator.pop(context);
                              } catch (e) {
                                print(e);
                                await showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    Future.delayed(Duration(seconds: 2), () {
                                      Navigator.of(context).pop();
                                    });
                                    return CupertinoAlertDialog(
                                      title: Text('Error'),
                                      content: Text(e.message??'error'),
                                    );
                                  },
                                );
                                setState(() {
                                  spinner = false;
                                });
                              }
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
