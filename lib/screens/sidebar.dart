import 'package:e_commerce/constants.dart';
import 'package:e_commerce/model/model.dart';
import 'package:e_commerce/screens/signinPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class sideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text('Account'),
            onTap: () => Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ChangeNotifierProvider(create: (BuildContext context) {return SpinnerProvider(); },
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
    );
  }
}
