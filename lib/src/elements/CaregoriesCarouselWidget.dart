import 'package:flutter/material.dart';

import '../elements/CategoriesCarouselItemWidget.dart';
import '../elements/CircularLoadingWidget.dart';
import '../models/category.dart';
import '../helpers/app_config.dart' as config;

// ignore: must_be_immutable
class CategoriesCarouselWidget extends StatelessWidget {
  List<Category> categories;

  CategoriesCarouselWidget({Key key, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.categories.isEmpty
        ? Column()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: config.App(context).appHeight(65),
            child: Center(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: ScrollPhysics(),
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 1.1,

                  // childAspectRatio:config.App(context).appWidth(95)/config.App(context).appHeight(45)
                    ),
                itemCount: this.categories.length,
                itemBuilder: (context, index) {
                  double _marginLeft = 0;
                  return GridTile(
                      child: CategoriesCarouselItemWidget(
                    marginLeft: _marginLeft,
                    category: this.categories.elementAt(index),
                  ));
                },
              ),
            ),

            //   itemCount: this.categories.length,
            //   scrollDirection: Axis.vertical,
            //   itemBuilder: (context, index) {
            //     double _marginLeft = 0;
            //     // (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
            //     return new CategoriesCarouselItemWidget(
            //       marginLeft: _marginLeft,
            //       category: this.categories.elementAt(index),
            //     );
            //   },
            // )
          );
  }
}
