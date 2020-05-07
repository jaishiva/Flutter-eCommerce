import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const Color backgroundColor = Color(0xFF11214d);
const Color sidebarColor = Colors.white;
const mainTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w800
  
);
const categoryTextStyleActive = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w600,
  color: Colors.lightBlueAccent
);
const categoryTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: Colors.white54
);
const productTextStyle = TextStyle(
  fontSize: 22,
  
);
const url = 'https://firebasestorage.googleapis.com/v0/b/';
const api = '?alt=media&token=229bb9d2-be16-43d7-966f-473241fa22b7';

List cart = [];

class SizeConfig {
 static MediaQueryData _mediaQueryData;
 static double screenWidth;
 static double screenHeight;
 static double blockSizeHorizontal;
 static double blockSizeVertical;
 
 static double safeAreaHorizontal;
 static double safeAreaVertical;
 static double safeBlockHorizontal;
 static double safeBlockVertical;
 
 void init(BuildContext context) {
 _mediaQueryData = MediaQuery.of(context);
 screenWidth = _mediaQueryData.size.width;
 screenHeight = _mediaQueryData.size.height;
 blockSizeHorizontal = screenWidth / 100;
 blockSizeVertical = screenHeight / 100;
 
 safeAreaHorizontal = _mediaQueryData.padding.left +
 _mediaQueryData.padding.right;
 safeAreaVertical = _mediaQueryData.padding.top +
 _mediaQueryData.padding.bottom;
 safeBlockHorizontal = (screenWidth -
 safeAreaHorizontal) / 100;
 safeBlockVertical = (screenHeight -
 safeAreaVertical) / 100;
 }
}