import 'package:e_commerce/constants.dart';
import 'package:e_commerce/model/model.dart';
import 'package:e_commerce/screens/signinPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class sideBar extends StatefulWidget {
  @override
  _sideBarState createState() => _sideBarState();
}

class _sideBarState extends State<sideBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        width: 80,
              child: loggedInUser != null
            ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    child: Text(
                      'Logout',
                      style: productTextStyle,
                    ),
                    onTap: () {
                      loggedInUser = null;
                      cart = null;
                      favorite = null;
                      showCupertinoModalPopup(
                          semanticsDismissible: true,
                          context: context,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                            });
                            return CupertinoAlertDialog(
                              title: Text('Success'),
                              content: Text('User Logged Out successfully'),
                            );
                          });
                        setState(() {});
                    },
                  ),
                ),
              )
            : ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.account_box),
                    title: Text('Account'),
                    
                    onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              ChangeNotifierProvider(
                                  create: (BuildContext context) {
                                    return SpinnerProvider();
                                  },
                                  child: SigninPage()),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = 0.0;
                            var end = 1.0;
                            var curve = Curves.linear;

                            var tween = Tween(begin: begin, end: end);
                            var curvedAnimation = CurvedAnimation(
                              parent: animation,
                              curve: curve,
                            );

                            return ScaleTransition(
                              scale: tween.animate(curvedAnimation),
                              child: child,
                            );
                          }),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
