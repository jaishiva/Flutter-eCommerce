import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool spinner = true;
  double total = 0;
  FirebaseFirestore _fireStore;
  List<ListTile> cartItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (loggedInUser != null) {
      setCart();
    } else {
      spinner = false;
    }
    ;
  }

  void setCart() async {
    total = 0;
    Firebase.initializeApp();
    _fireStore = FirebaseFirestore.instance;
    cart = await _fireStore
        .collection(loggedInUser.user.email)
        .doc('cart')
        .collection('0')
        .get();

    await Future.forEach(cart.docs, (QueryDocumentSnapshot item) async {
      var docRef = await _fireStore
          .doc(item.data()['ref'])
          .get()
          .then((value) => value.data()[item.data()['index']]);
      total = total +
          item.data()['quantity'] * double.parse(docRef['price'].toString());
      print(total);
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
                  .doc('cart')
                  .collection('0')
                  .doc(documentID)
                  .delete();

              if (this.mounted) {
                cartItems = [];
                setCart();
                setState(() {});
              }
            }),
      );
      cartItems.add(tempTile);
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
    return cart == null
        ? loggedInUser != null
            ? Center(
                child: Text(
                  'Cart Empty\nAdd items to Cart',
                  textAlign: TextAlign.center,
                ),
              )
            : Center(
                child: Text(
                  'Login to Add items to Cart',
                  textAlign: TextAlign.center,
                ),
              )
        : ModalProgressHUD(
            color: backgroundColor,
            opacity: 1.0,
            inAsyncCall: spinner,
            child: spinner
                ? Container(
                    color: Colors.black,
                  )
                : cart.docs.length == 0
                    ? Center(
                        child: Text(
                          'Cart Empty\nAdd items to Cart',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 7, child: ListView(children: cartItems)),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.all(7),
                              child: CupertinoButton(
                                color: Colors.teal,
                                onPressed: () {
                                  print(total);
                                },
                                child: Text(
                                  'Check Out \$$total',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
          );
  }
}
