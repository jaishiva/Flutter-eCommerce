import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';


class customFlatButton extends StatelessWidget {
  customFlatButton({
    this.icon,
    this.text,
    this.onPressed,
    this.active
});
  final IconData icon;
  final String text;
  final Function onPressed;
  final bool active;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(SizeConfig.safeBlockVertical*2.2),
            decoration: BoxDecoration(
              color: active?Colors.tealAccent:Colors.white24,
              borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical*2.2),

            ),
            child: Icon(
              icon,
              size: 30,
              color: active?Colors.black:Colors.white54,
            ),
          ),
          SizedBox(height: 10,),
          Text(text,style: active?categoryTextStyleActive:categoryTextStyle,)
        ],
      ),
    );
  }
}