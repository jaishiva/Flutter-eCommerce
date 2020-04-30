import 'package:e_commerce/widgets/icons.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'productPage.dart';
import 'package:e_commerce/model/model.dart';
import 'itemPage.dart';

class frontpage extends StatefulWidget {
  final Function callback;
  frontpage({this.callback});
  @override
  _frontpageState createState() => _frontpageState();
}

class _frontpageState extends State<frontpage> {
  int selectedIndex = 0;
  bool chair = true;
  bool table = false;
  bool lamp = false;
  bool bed = false;
  List category = chairList;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    
    return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: backgroundColor,
            leading: GestureDetector(
              onTap: widget.callback,
              child: Icon(Icons.filter_list,size: 40,)
            ),
            actions: [
              GestureDetector(
                child: Icon(Icons.search,size: 40,),
                onTap: () => null,
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Let's find\nyour favorite Furniture",style: mainTextStyle,),
                SizedBox(height: SizeConfig.blockSizeVertical*2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customFlatButton(
                      icon: FontAwesomeIcons.chair,
                      active: chair,
                      onPressed: (){
                        setState(() {
                          category = chairList;
                          chair = true;
                          table = false;
                          lamp = false;
                          bed = false;
                        });
                      },
                      text: 'Chair',
                    ),
                    customFlatButton(
                      icon: FontAwesomeIcons.table,
                      active : table,
                      onPressed: (){
                        setState(() {
                          category = tableList;
                          chair = false;
                          table = true;
                          lamp = false;
                          bed = false;
                        });
                      },
                      text: 'Table',
                    ),
                    customFlatButton(
                      icon: FontAwesomeIcons.lightbulb,
                      active: lamp,
                      onPressed: (){
                        setState(() {
                          category = lampList;
                          chair = false;
                          table = false;
                          lamp = true;
                          bed = false;
                        });
                      },
                      text: 'Lamp',
                    ),
                    customFlatButton(
                      icon: FontAwesomeIcons.bed,
                      active: bed,
                      onPressed: (){
                        setState(() {
                          category = bedList;
                          chair = false;
                          table = false;
                          lamp = false;
                          bed = true;
                        });
                      },
                      text: 'Bed',
                    ),

                  ],
                ),
               Center(child: productPage(category : category))
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(

            iconSize: SizeConfig.blockSizeHorizontal*7,
            backgroundColor: backgroundColor,

            items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.home,),
              title: Text('')
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.heart),
              title: Text('')
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.shoppingCart),
              title: Text(''),
            ),
          ],
          currentIndex: selectedIndex,
          selectedIconTheme: IconThemeData(
            size: SizeConfig.blockSizeHorizontal*8,
            
          ),
          onTap: (newIndex){
            setState(() {
              selectedIndex = newIndex;
            });
            if(selectedIndex == 2){
              setState(() {
                selectedIndex = 0;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ItemPage(item: cart,);
              }));
            }
          }
          ),
        );
  }
}