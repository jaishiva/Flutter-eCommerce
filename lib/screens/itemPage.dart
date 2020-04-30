import 'package:e_commerce/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_commerce/model/model.dart';

class ItemPage extends StatefulWidget {
  ItemPage({this.item,this.index=0});
  final List item;
  final int index;
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  List<bool> isSelected;
  int index;
  int quantity = 1;
  @override
  void initState() {
    super.initState();
    print(widget.item.length);
    index = index = widget.index;
    isSelected = itemPageButtons(item: widget.item).init();
    print(isSelected.length);
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
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
                  GestureDetector(
                    onTap: (){Navigator.pop(context);},
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9)
                        ),
                        constraints: BoxConstraints(
                          minWidth: 40,
                          minHeight: 40
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){Navigator.pop(context);},
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9)
                        ),
                        constraints: BoxConstraints(
                            minWidth: 40,
                            minHeight: 40
                        ),
                        child: Icon(
                          FontAwesomeIcons.heart,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  children: [
                    Text('${widget.item[index][2]}  ',style: mainTextStyle,),
                    Text('⭐️${widget.item[index][0]}'),
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
                        Text('Price',style: productTextStyle,),
                        Text('\$${widget.item[index][3]}',style: mainTextStyle,),
                        SizedBox(height: 20,),
                        Text('Color Varient',style: productTextStyle,),
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: 45,
                            maxWidth: 145
                          ),
                          child: ListView.builder(itemBuilder: (context,i){
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    index = i;
                                  });
                                },
                                  child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 4, 6, 4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: widget.item[i][4],
                                      borderRadius: BorderRadius.circular(80),
                                      border: index != i?Border.all(width: 4,color: backgroundColor):Border.all(width: 0)
                                    ),
                                    constraints: BoxConstraints(
                                      minHeight: 38,
                                      minWidth: 38,
                                      maxHeight: 38,
                                      maxWidth: 38
                                    ),
                                  ),
                                ),
                              );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: isSelected.length,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text('Material',style: productTextStyle,),
                        Text('Wooden',style: mainTextStyle,)
                      ],
                    ),
                    ClipRect(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.65,
                        child: Image.asset(widget.item[index][1]),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 0, 6),
                child: Align(child: Text('About Product',style: productTextStyle,),alignment: Alignment.centerLeft,),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam feugiat lorem egestas interdum vulputate. Proin arcu lacus, molestie sed lectus nec, tincidunt tristique lacus. Aliquam erat volutpat.'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Align(child: Text('Quantity',style: productTextStyle,),alignment: Alignment.centerLeft,),
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
                        onPressed: (){
                          if(quantity>1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10,),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                        minRadius: 20,
                        maxRadius: 30,
                        child: Text(
                            '$quantity',
                            style: mainTextStyle
                        ),
                    ),
                    SizedBox(width: 10,),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      minRadius: 20,
                      maxRadius: 30,
                      child: IconButton(
                        icon: Icon(Icons.add,color: Colors.black,),
                        onPressed: (){
                          if(quantity<10) {
                            setState(() {
                              quantity++;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                        child: CupertinoButton(
                          color: Colors.teal,
                            padding: EdgeInsets.all(0),
                            minSize: 60,
                            child: Text('Add to cart',style: mainTextStyle,),
                            onPressed: (){
                              cart.add(widget.item[index]);
                              print(cart);
                            }
                        )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}