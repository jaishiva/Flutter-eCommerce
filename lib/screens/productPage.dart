import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_commerce/constants.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'itemPage.dart';

class ProductPage extends StatefulWidget {
  ProductPage({this.category});

  final QuerySnapshot category;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with SingleTickerProviderStateMixin{
AnimationController animationController;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  PageViewIndicator pageIndicator() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: widget.category.docs.length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.white38,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 12.0,
          color: Colors.accents.elementAt((index + 3) * 3),
        ),
      ),
    );
  }

  final pageIndexNotifier = ValueNotifier<int>(0);

  var categoryList;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2)
    );
  }
@override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.value = 0;
    print('prodPage');
    SizeConfig().init(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(
                maxHeight: SizeConfig.safeBlockVertical * 42,
                maxWidth: SizeConfig.safeBlockHorizontal * 55),
            decoration: BoxDecoration(
                color: backgroundColor, 
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(
                  color: Colors.white,
                  blurRadius: 5
                )]
                ),
            child: PageView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '⭐️${widget.category.docs[index].data()['0']['rating']}'),
                         AnimatedBuilder(
                           child: GestureDetector(
                             onTap: () async{
                               if(loggedInUser != null){animationController.repeat();
                               await _fireStore.collection(loggedInUser.user.email).doc('favorite').collection('0').add({'ref' : widget.category.docs[index].reference.path,'index' : 0});
                              favorite = await _fireStore.collection(loggedInUser.user.email).doc('favorite').collection('0').get();
                              animationController.value = 1;
                              animationController.stop();}
                             },
                             child: Icon(FontAwesomeIcons.heart,)
                            ),
                           animation: animationController, 
                           builder: (context,child){
                             return Transform(origin: Offset(15, 15),
                               transform: Matrix4.rotationY(animationController.value*6),
                               child: child,
                             );
                           }
                           )
                          
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ItemPage(
                            item: widget.category.docs[index],
                          );
                        })),
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Hero(
                              tag: '1',
                              child: Image.network(
                                "${widget.category.docs[index].data()['0']['image']}",
                                scale: SizeConfig.safeBlockHorizontal / 3,
                              )),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.category.docs[index].data()['0']['name']}\n\$ ${widget.category.docs[index].data()['0']['price']}',
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: widget.category.docs.length,
              onPageChanged: (index) => pageIndexNotifier.value = index,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          pageIndicator()
        ],
      ),
    );
  }
}
