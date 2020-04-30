import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';

class sideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
        body: ListView(
          children: [
          ListTile(leading: Icon(Icons.account_box),title: Text('Account'),)
        ],
      ),
    );
  }
}