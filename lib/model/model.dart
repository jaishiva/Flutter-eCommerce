import 'package:flutter/material.dart';

List chairList = [
  [[4.0,'assets/chair.png','Invisible Chair',50,Colors.white10],
    [4.2,'assets/chair1.png','Gold Chair',35,Colors.yellowAccent],
    [4.6,'assets/armchair.png','Dark Gold Chair',25,Colors.yellow]],
  [[4.0,'assets/office-chair.png','Pink Office Chair',50,Colors.pinkAccent],
    [4.2,'assets/office-chair1.png','Dark Pink Chair',35,Colors.pink],
    [4.6,'assets/office-chair2.png','Invisible Office Chair',25,Colors.white10]]
];
List tableList = [
  [[4.0,'assets/table.png','Colorful Table',50,Colors.blueGrey],
    [4.2,'assets/table1.png','Blue Table',35,Colors.blue],
    [4.6,'assets/table2.png','Brown Table',25,Colors.brown]],
];
List lampList = [];
List bedList = [];


class itemPageButtons{
  itemPageButtons({@required this.item});
  final List item;
  List<bool> isSelected = [true];
  List<bool> init(){
    for(var i=1;i< item.length;i++){
      isSelected.add(false);
    }
    return isSelected;
  }
}