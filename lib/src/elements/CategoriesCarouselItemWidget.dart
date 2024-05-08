import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/category.dart';
import '../models/route_argument.dart';
import '../helpers/app_config.dart' as config;
// ignore: must_be_immutable
class CategoriesCarouselItemWidget extends StatelessWidget {
  double marginLeft;
  Category category;
  CategoriesCarouselItemWidget({Key key, this.marginLeft, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pushNamed('/Category', arguments: RouteArgument(id: category.id));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: category.id,
            child:

            ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    // margin: EdgeInsetsDirectional.only(start: this.marginLeft, end: 20),
                    width: config.App(context).appWidth(40),
                    height: config.App(context).appWidth(40),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.2),
                            offset: Offset(0, 2), blurRadius: 5.0)]),
                    child:
                       category.image.url.toLowerCase().endsWith('.svg')
                          ? SvgPicture.network(
                              category.image.url,
                              color: Theme.of(context).accentColor,
                            )
                          : CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: category.image.icon,
                              placeholder: (context, url) => Image.asset(
                                'assets/img/loading.gif',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error_outline),
                            ),

                  ),
                ),
                // Container(
                //   child: Text(
                //     category.name,
                //     overflow: TextOverflow.ellipsis,
                //     style: Theme.of(context).textTheme.bodyText2,
                //   ),
                // ),

          ),
          SizedBox(height: 5),

        ],
      ),
    );
  }
}
