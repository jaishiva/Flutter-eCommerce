import 'package:flutter/material.dart';

class CustomButtonsAppBar extends StatelessWidget {
  const CustomButtonsAppBar({
    Key key,
    this.icon
  }) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9)),
          constraints:
              BoxConstraints(minWidth: 40, minHeight: 40),
          child: Icon(
            icon,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}