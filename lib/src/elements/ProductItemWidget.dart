import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../models/product.dart';
import '../models/route_argument.dart';

class ProductItemWidget extends StatelessWidget {
  final String heroTag;
  final Product product;

  const ProductItemWidget({Key key, this.product, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.of(context).pushNamed('/Product', arguments: RouteArgument(id: product.id, heroTag: this.heroTag));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Hero(
              tag: heroTag + product.id,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: CachedNetworkImage(
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  imageUrl: product.image.thumb,
                  placeholder: (context, url) => Image.asset(
                    'assets/img/loading.gif',
                    fit: BoxFit.cover,
                    height: 60,
                    width: 60,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error_outline),
                ),
              ),
            ),

            Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,

                  style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: Theme.of(context).accentColor)),
                ),
                SizedBox(height: 10,),
                Text(
                  product.market.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.subtitle2,
                ),

              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(product.market.rate,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .merge(TextStyle(
                        color: Theme.of(context).accentColor))),
                Icon(
                  Icons.star_border,
                  color: Theme.of(context).accentColor,
                  size: 16,
                ),
              ],
            ),
            // SizedBox(width: 30),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                product.discountPrice > 0
                    ? Helper.getPrice(
                    product.discountPrice, context,

                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .merge(TextStyle(
                      decoration:
                      TextDecoration.lineThrough,)))
                    : SizedBox(height: 0),
                Helper.getPrice(
                  product.price,


                  context,

                  // style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
