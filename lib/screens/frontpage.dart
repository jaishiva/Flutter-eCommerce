import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widgets/icons.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'productPage.dart';
import 'package:e_commerce/model/model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Frontpage extends StatefulWidget {
  Frontpage({this.callback});
  final callback;

  @override
  _FrontpageState createState() => _FrontpageState();
}

class _FrontpageState extends State<Frontpage> {
  Firestore _firestore = Firestore.instance;
  int selectedIndex = 0;
  Data provider;
  SpinnerProvider spinnerProvider;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    print('build');
    SizeConfig().init(context);
    Data().init();
    provider = Provider.of<Data>(context,listen: false);
    spinnerProvider = Provider.of<SpinnerProvider>(context,listen: false);
    return Consumer<SpinnerProvider>(
      builder: (context, spin, child) => 
        ModalProgressHUD(
          inAsyncCall: spin.showSpinner,
          child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: backgroundColor,
            leading: GestureDetector(
                onTap: widget.callback,
                child: Icon(
                  Icons.filter_list,
                  size: 40,
                )),
            actions: [
              GestureDetector(
                child: Icon(
                  Icons.search,
                  size: 40,
                ),
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
                Text(
                  "Let's find\nyour favorite Furniture",
                  style: mainTextStyle,
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<Data>(
                      builder: (_, data, __) => customFlatButton(
                        icon: FontAwesomeIcons.chair,
                        active: data.chair,
                        onPressed: () async{
                          spinnerProvider.toggleSpinner();
                          chairListData??= await _firestore.collection('chairs').getDocuments();
                          spinnerProvider.toggleSpinner();
                          data.setButtons(
                              true, false, false, false, chairListData);
                        },
                        text: 'Chair',
                      ),
                    ),
                    Consumer<Data>(
                      builder: (_, data, __) => customFlatButton(
                        icon: FontAwesomeIcons.table,
                        active: data.table,
                        onPressed: () async{
                          spinnerProvider.toggleSpinner();
                          tableListData??= await _firestore.collection('tables').getDocuments();
                          spinnerProvider.toggleSpinner();
                          data.setButtons(
                              false, true, false, false, tableListData);
                        },
                        text: 'Table',
                      ),
                    ),
                    Consumer<Data>(
                      builder: (_, data, __) => customFlatButton(
                        icon: FontAwesomeIcons.lightbulb,
                        active: data.lamp,
                        onPressed: () async{
                          spinnerProvider.toggleSpinner();
                          chairListData??= await _firestore.collection('chairs').getDocuments();
                          spinnerProvider.toggleSpinner();
                          data.setButtons(
                              false, false, true, false, chairListData);
                        },
                        text: 'Lamp',
                      ),
                    ),
                    Consumer<Data>(
                      builder: (_, data, __) => customFlatButton(
                        icon: FontAwesomeIcons.bed,
                        active: data.bed,
                        onPressed: () async{
                          spinnerProvider.toggleSpinner();
                          tableListData??= await _firestore.collection('tables').getDocuments();
                          spinnerProvider.toggleSpinner();
                          data.setButtons(
                              false, false, false, true, tableListData);
                        },
                        text: 'Bed',
                      ),
                    )
                  ],
                ),
                Consumer<SpinnerProvider>(builder: (_,spin,__) =>
                Consumer<Data>(builder: (_,data,__) =>  Center(child: ProductPage(category: data.category)))
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              iconSize: SizeConfig.blockSizeHorizontal * 7,
              backgroundColor: backgroundColor,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.home,
                    ),
                    title: Text('')),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.heart), title: Text('')),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.shoppingCart),
                  title: Text(''),
                ),
              ],
              currentIndex: selectedIndex,
              selectedIconTheme: IconThemeData(
                size: SizeConfig.blockSizeHorizontal * 8,
              ),
              onTap: (newIndex) {
//            setState(() {
//              selectedIndex = newIndex;
//            });
//            if (selectedIndex == 2) {
//              setState(() {
//                selectedIndex = 0;
//              });
//              Navigator.push(context, MaterialPageRoute(builder: (context) {
//                return ItemPage(
//                  item: cart,
//                );
//              }));
//            }
              }),
      ),
        ),
    );
  }
}
