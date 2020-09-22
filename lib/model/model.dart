import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

QuerySnapshot chairListData;
QuerySnapshot tableListData;

class Data with ChangeNotifier{

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