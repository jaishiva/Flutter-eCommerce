import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

QuerySnapshot chairListData;
QuerySnapshot tableListData;

class Data with ChangeNotifier{
  static List _chairList = [
    [[4.0,'assets/chair.png','Invisible Chair',50,Colors.white10],
      [4.2,'assets/chair1.png','Gold Chair',35,Colors.yellowAccent],
      [4.6,'assets/armchair.png','Dark Gold Chair',25,Colors.yellow]],
    [[4.0,'assets/office-chair.png','Pink Office Chair',50,Colors.pinkAccent],
      [4.2,'assets/office-chair1.png','Dark Pink Chair',35,Colors.pink],
      [4.6,'assets/office-chair2.png','Invisible Office Chair',25,Colors.white10]]
  ];
  static List _tableList = [
    [[4.0,'assets/table.png','Colorful Table',50,Colors.blueGrey],
      [4.2,'assets/table1.png','Blue Table',35,Colors.blue],
      [4.6,'assets/table2.png','Brown Table',25,Colors.brown]],
  ];
  static List _lampList = [];
  static List _bedList = [];
  int _mainIndex;
  int _subIndex;
  List active;
  bool chair = true;
  bool table = false;
  bool lamp = false;
  bool bed = false;
  QuerySnapshot category = chairListData;
  void init(){
    _mainIndex = 0;
    _subIndex = 0;
    chair = true;
    table = false;
    lamp = false;
    bed = false;
  }
  int get mainIndex => _mainIndex;
  int get subIndex => _subIndex;
  List get chairList => _chairList;
  List get tableList => _tableList;
  List get lampList => _lampList;
  List get bedList => _bedList;
  set mainIndex(int newIndex){
    _mainIndex = newIndex;
    notifyListeners();
  }
  set subIndex(int newIndex){
    _subIndex = newIndex;
    notifyListeners();
  }

  void setButtons(c,t,l,b,cat){
    chair = c;
    table = t;
    lamp = l;
    bed = b;
    category = cat;
    notifyListeners();
  }
}

class itemPageButtons{
  itemPageButtons({@required this.item});
  final Map item;
  List<bool> isSelected = [true];
  List<bool> init(){
    for(var i=1;i< item.length;i++){
      isSelected.add(false);
    }
    return isSelected;
  }
}

class SpinnerProvider extends ChangeNotifier{
  bool showSpinner = false;
  void toggleSpinner(){
    showSpinner = !showSpinner;
    notifyListeners();
  }
}