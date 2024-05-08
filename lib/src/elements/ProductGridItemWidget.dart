import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../models/product.dart';
import '../models/route_argument.dart';

class ProductGridItemWidget extends StatefulWidget {
  final String heroTag;
  final Product product;
  final VoidCallback onPressed;

  ProductGridItemWidget({Key key, this.heroTag, this.product, this.onPressed})
      : super(key: key);

  @override
  _ProductGridItemWidgetState createState() => _ProductGridItemWidgetState();
}

class _ProductGridItemWidgetState extends State<ProductGridItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('/Product',
            arguments: new RouteArgument(
                heroTag: this.widget.heroTag, id: this.widget.product.id));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Image.network(this.widget.product.image.thumb,
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.product.name,
                                style: Theme.of(context).textTheme.bodyText1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  widget.product.discountPrice > 0
                                      ? Helper.getPrice(
                                          widget.product.discountPrice, context,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .merge(TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough)))
                                      : SizedBox(height: 0),
                                  Helper.getPrice(
                                    widget.product.price,
                                    context,
                                    // style:
                                    //     Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(

                                child:
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).pushNamed('/Details',
                                        arguments: RouteArgument(
                                          id: '0',
                                          param: widget.product.market.id,
                                          heroTag: widget.heroTag,
                                        ));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.turn_left,color: Theme.of(context).accentColor,),
                                      Flexible(
                                        child: Text(
                                          widget.product.market.name,
                                          maxLines: 4,


                                          style:TextStyle(decoration: TextDecoration.underline,color: Theme.of(context).accentColor),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(widget.product.market.rate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .merge(TextStyle(
                                              color: Theme.of(context)
                                                  .hintColor))),
                                  Icon(
                                    Icons.star_border,
                                    color: Theme.of(context).hintColor,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     widget.onPressed();
                  //   },
                  //   child:
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                           ),
                      ),
                      margin: EdgeInsets.only(right: 10),
                      width: 100,
                      height: 70,
                      child: Icon(
                          Icons.add_shopping_cart,
                          color: Theme.of(context).primaryColor,
                          size: 26,
                        ),
                      ),

                  // ),
                ],
              ),

          ],
        ),
      ),
    );
  }
}
