import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/frontpage.dart';
import 'package:flutter/material.dart';
import 'sidebar.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  AnimationController animationController;
  @override
  void initState(){
    super.initState();
    
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400)
    );
  }

  void toggle(){
    animationController.isDismissed? animationController.forward():animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        double slide =  SizeConfig.safeBlockHorizontal*50*animationController.value;
        return Stack(
        children: [
          sideBar(),
          Transform(
            transform: Matrix4.identity()
            ..translate(slide),
            alignment: Alignment.centerLeft,
            child: frontpage(callback : toggle)
          ),
        ],
      );
      },
       
    );
  }
}