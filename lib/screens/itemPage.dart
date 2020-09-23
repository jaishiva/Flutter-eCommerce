import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/widgets/custombuttonAppbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_commerce/model/model.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class ItemPage extends StatefulWidget {
  ItemPage({this.item, this.index = '0'});
  final DocumentSnapshot item;
  final String index;
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage>
    with SingleTickerProviderStateMixin {
  List<bool> isSelected;
  AnimationController animationController;
  String index;
  int quantity = 1;
  Map<String, dynamic> item;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  bool spin = false;
  @override
  void initState() {
    super.initState();
    item = widget.item.data();
    print(item.length);
    index = widget.index;
    isSelected = itemPageButtons(item: item).init();
    print(isSelected.length);
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: spin,
      child: Container(
        color: backgroundColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: backgroundColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButtonsAppBar(
                      icon: Icons.arrow_back_ios,
                    ),
                    AnimatedBuilder(
                        child: GestureDetector(
                          onTap: () async {
                            if (loggedInUser != null) {
                              animationController.repeat();
                              await _fireStore
                                  .collection(loggedInUser.user.email)
                                  .doc('favorite')
                                  .collection('0')
                                  .add({
                                'ref': widget.item.reference.path,
                                'index': index
                              });
                              favorite = await _fireStore
                                  .collection(loggedInUser.user.email)
                                  .doc('favorite')
                                  .collection('0')
                                  .get();
                              animationController.value = 1;
                              animationController.stop();
                            }
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
                                FontAwesomeIcons.heart,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        animation: animationController,
                        builder: (context, child) {
                          return Transform(
                            origin: Offset(35, 35),
                            transform: Matrix4.rotationY(
                                animationController.value * 6),
                            child: child,
                          );
                        })
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Text(
                        '${widget.item.data()[index]['name']}',
                        style: mainTextStyle,
                      ),
                      Text('⭐️${widget.item.data()[index]['rating']}'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Price',
                            style: productTextStyle,
                          ),
                          Text(
                            '\$${widget.item.data()[index]['price']}',
                            style: mainTextStyle,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Color Varient',
                            style: productTextStyle,
                          ),
                          Container(
                            constraints:
                                BoxConstraints(maxHeight: 45, maxWidth: 145),
                            child: ListView.builder(
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      index = i.toString();
                                    });
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 4, 6, 4),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(int.parse(widget.item
                                              .data()[i.toString()]['color'])),
                                          borderRadius:
                                              BorderRadius.circular(80),
                                          border: index != i.toString()
                                              ? Border.all(
                                                  width: 4,
                                                  color: backgroundColor)
                                              : Border.all(width: 0)),
                                      constraints: BoxConstraints(
                                          minHeight: 38,
                                          minWidth: 38,
                                          maxHeight: 38,
                                          maxWidth: 38),
                                    ),
                                  ),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: item.length,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Material',
                            style: productTextStyle,
                          ),
                          Text(
                            'Wooden',
                            style: mainTextStyle,
                          )
                        ],
                      ),
                      ClipRect(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.65,
                          child: Hero(
                              tag: '1',
                              child: Image.network(item[index]['image'])),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 6),
                  child: Align(
                    child: Text(
                      'About Product',
                      style: productTextStyle,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam feugiat lorem egestas interdum vulputate. Proin arcu lacus, molestie sed lectus nec, tincidunt tristique lacus. Aliquam erat volutpat.'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    child: Text(
                      'Quantity',
                      style: productTextStyle,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        minRadius: 20,
                        maxRadius: 30,
                        child: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        minRadius: 20,
                        maxRadius: 30,
                        child: Text('$quantity', style: mainTextStyle),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        minRadius: 20,
                        maxRadius: 30,
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            if (quantity < 10) {
                              setState(() {
                                quantity++;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CupertinoButton(
                          color: Colors.teal,
                          padding: EdgeInsets.all(0),
                          minSize: 60,
                          child: Text(
                            'Add to cart',
                            style: mainTextStyle,
                          ),
                          onPressed: () async {
                            if (loggedInUser == null) {
                              showDialog(
                                  context: context,
                                  child: AlertDialog(
                                      title: Text(
                                          'Please login \nto add items to cart')));
                            } else {
                              setState(() {
                                spin = true;
                              });
                              await _fireStore
                                  .collection(loggedInUser.user.email)
                                  .doc('cart')
                                  .collection('0')
                                  .add({
                                'ref': widget.item.reference.path,
                                'index': index,
                                'quantity': quantity
                              });
                              cart = await _fireStore
                                  .collection(loggedInUser.user.email)
                                  .doc('cart')
                                  .collection('0')
                                  .get();
                              showDialog(
                                  context: context,
                                  child: AlertDialog(
                                      titlePadding:
                                          EdgeInsets.fromLTRB(50, 20, 0, 20),
                                      elevation: 5,
                                      title: Text('Item added to cart')));
                              setState(() {
                                spin = false;
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
