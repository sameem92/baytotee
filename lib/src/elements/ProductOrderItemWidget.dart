import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../models/order.dart';
import '../models/product_order.dart';
import '../models/route_argument.dart';

class ProductOrderItemWidget extends StatelessWidget {
  final String heroTag;
  final ProductOrder productOrder;
  final Order order;
  // final bool lastIndex;

  const ProductOrderItemWidget({Key key, this.productOrder, this.order, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.of(context).pushNamed('/Product', arguments: RouteArgument(id: this.productOrder.product.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: heroTag + productOrder?.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: CachedNetworkImage(
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                      imageUrl: productOrder.product.image.thumb,
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
                SizedBox(width: 15),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              productOrder.product.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            // Wrap(
                            //   children: List.generate(productOrder.options.length, (index) {
                            //     return Text(
                            //       productOrder.options.elementAt(index).name + ', ',
                            //       style: Theme.of(context).textTheme.caption,
                            //     );
                            //   }),
                            // ),
                            // Text(
                            //   productOrder.product.market.name,
                            //   overflow: TextOverflow.ellipsis,
                            //   maxLines: 2,
                            //   style: Theme.of(context).textTheme.caption,
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "  العدد :  " +productOrder.quantity.toString()  ,
                                style: Theme.of(context).textTheme.caption,
                              ),
                              SizedBox(width: 10,),

                              Helper.getPrice(Helper.getOrderPrice(productOrder), context, style: Theme.of(context).textTheme.subtitle1),

                              // Text("${productOrder.price*productOrder.quantity)}")
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            // lastIndex?
            Divider(color: Theme.of(context).accentColor.withOpacity(.4),)
                // :SizedBox()
          ],
        ),
      ),
    );
  }
}
