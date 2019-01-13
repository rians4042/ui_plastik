import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:Recet/presentations/screens/home/values/list-item.dart';
import 'package:Recet/presentations/screens/home/values/list-report.dart';
import 'package:Recet/presentations/screens/home/widgets/item-home.dart';
import 'package:Recet/values/colors.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final maxHeightCarousel = MediaQuery.of(context).size.height * 0.2;
    return SingleChildScrollView(
      primary: true,
      child: Column(
        children: <Widget>[
          Container(
            color: WHITE_COLOR,
            padding: EdgeInsets.symmetric(vertical: 18),
            child: CarouselSlider(
              initialPage: 0,
              reverse: false,
              height: maxHeightCarousel,
              items: summaryReports.map((Widget widget) => widget).toList(),
              autoPlay: false,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 12,
              right: 12,
              top: 8,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext ctx, int index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 4),
                        child: Text(
                          items[index]['sectionTitle'],
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: (items[index]['details'] as List).length,
                        itemBuilder: (BuildContext ctx, int childindex) =>
                            ItemHome(
                              label: (items[index]['details']
                                  as List)[childindex]['name'],
                              assetPath: (items[index]['details']
                                  as List)[childindex]['asset'],
                              onPress: () {
                                (items[index]['details'] as List)[childindex]
                                    ['onPress'](ctx);
                              },
                            ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
