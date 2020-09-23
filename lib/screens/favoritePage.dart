import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool spinner = true;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  List<ListTile> favoriteItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(loggedInUser!=null){setFav();}
    else{
      spinner = false;
    };
  }

  void setFav() async {
    var app = await Firebase.initializeApp();
    favorite = await _fireStore
        .collection(loggedInUser.user.email)
        .doc('favorite')
        .collection('0')
        .get();

    await Future.forEach(favorite.docs, (item) async {
      var docRef = await _fireStore
          .doc(item.data['ref'])
          .get()
          .then((value) => value.data()["${item.data['index']}"]);
      ListTile tempTile = ListTile(
        leading: Image.network(docRef['image']),
        title: Text(docRef['name']),
        trailing: MaterialButton(
            child: Text('Delete'),
            onPressed: () async {
              setState(() {
                spinner = true;
              });
              var documentID = item.documentID;
              await _fireStore
                  .collection(loggedInUser.user.email)
                  .doc('favorite')
                  .collection('0')
                  .doc(documentID)
                  .delete();

              if (this.mounted) {
                favoriteItems = [];
                setFav();
                setState(() {
                  
                });

              }
            }),
      );
      favoriteItems.add(tempTile);
    }).whenComplete(() {
      if (this.mounted) {
        setState(() {
          spinner = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  favorite==null?loggedInUser!=null? Center(
                        child: Text(
                          'Favorite List Empty\nAdd items to Favorite',
                          textAlign: TextAlign.center,
                        ),
                      ):Center(
                        child: Text(
                          'Login to add items to Favorite',
                          textAlign: TextAlign.center,
                        ),
                      ):ModalProgressHUD(
            color: backgroundColor,
            opacity: 1,
            inAsyncCall: spinner,
            child: spinner
                ? Container(
                    color: Colors.black,
                  )
                : favorite.docs.length == 0
                    ? Center(
                        child: Text(
                          'Favorite List Empty\nAdd items to Favorite',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 7, child: ListView(children: favoriteItems)),
                        ],
                      ),
          );
  }
}
