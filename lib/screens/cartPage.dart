import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
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
  Firestore _fireStore = Firestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCart();
  }

  void setCart() async {
    cart = await _fireStore
        .collection(loggedInUser.user.email)
        .document('cart')
        .collection('0')
        .getDocuments();
    setState(() {
      spinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    total = 0;
    return cart.documents.length == 0
        ? Center(
            child: Text(
              'Cart Empty\nAdd items to Cart',
              textAlign: TextAlign.center,
            ),
          )
        : ModalProgressHUD(
            inAsyncCall: spinner,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 7,
                  child: ListView.builder(
                      itemCount: cart.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListTile(
                            leading: Image.network(
                                cart.documents[index]['image']),
                                title: Text(cart.documents[index]['name']),
                                trailing: MaterialButton(
                                    child: Text('Delete'),
                                    onPressed: () async {
                                      setState(() {
                                        spinner = true;
                                      });
                                      var documentID =
                                          cart.documents[index].documentID;
                                      await _fireStore
                                          .collection(loggedInUser.user.email)
                                          .document('cart')
                                          .collection('0')
                                          .document(documentID)
                                          .delete();
                                      cart = await _fireStore
                                          .collection(loggedInUser.user.email)
                                          .document('cart')
                                          .collection('0')
                                          .getDocuments();
                                      setState(() {
                                        spinner = false;
                                      });
                                    }),
                          ),
                        );
                      }),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(7),
                    child: CupertinoButton(
                      color: Colors.teal,
                      onPressed: () {},
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
