import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_commerce/constants.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'itemPage.dart';
class productPage extends StatelessWidget {
  productPage({
    this.category
  });

PageViewIndicator pageIndicator() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: category.length,
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
  final List category;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
        constraints: BoxConstraints(
    maxHeight: SizeConfig.safeBlockVertical*42,
    maxWidth: SizeConfig.safeBlockHorizontal*55
        ),
        decoration: BoxDecoration(
    color: Colors.white30,
    borderRadius: BorderRadius.circular(20)
        ),
        child: PageView.builder(
    
    itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){
                return ItemPage(item: category[index],);
              })),
              child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('⭐️${category[index][0][0]}'),
                      Icon(FontAwesomeIcons.heart)
                    ],
                  ),
                  Image.asset(category[index][0][1],scale: SizeConfig.safeBlockHorizontal/3,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${category[index][0][2]}\n\$ ${category[index][0][3]}',
                        style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal*5,
                      ),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),
          );
    },
    itemCount: category.length,
    onPageChanged: (index) => pageIndexNotifier.value = index,

        ),
        
    ),
    SizedBox(height: 20,),
    pageIndicator()
        ],
      ),
      );
  }
}
