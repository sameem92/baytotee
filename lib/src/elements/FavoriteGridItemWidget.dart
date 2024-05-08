import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../models/favorite.dart';
import '../models/route_argument.dart';

class FavoriteGridItemWidget extends StatelessWidget {
  final String heroTag;
  final Favorite favorite;

  FavoriteGridItemWidget({Key key, this.heroTag, this.favorite})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('/Product',
            arguments: new RouteArgument(
                heroTag: this.heroTag, id: this.favorite.product.id));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex:9,
              child: SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Image.network(this.favorite.product.image.thumb,
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              flex: 2,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        favorite.product.name,
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          favorite.product.discountPrice > 0
                              ? Helper.getPrice(
                                  favorite.product.discountPrice, context,

                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .merge(TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,)))
                              : SizedBox(height: 0),
                          Helper.getPrice(
                            favorite.product.price,


                            context,

                            // style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(favorite.product.market.rate,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .merge(TextStyle(
                                  color: Theme.of(context).hintColor))),
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
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(

                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushNamed('/Details', arguments:
                              RouteArgument(id: '0', param:favorite.product.market.id));

                              // _con.product?.market?.id
                            },
                            child: Row(
                              children: [
                                SizedBox(width: 30,),
                                Icon(Icons.turn_left,color: Theme.of(context).accentColor,),
                                Text(
                                  "${favorite.product.market.name ?? ''}",
                                  overflow: TextOverflow.ellipsis,


                                  maxLines: 3,
                                  style:TextStyle(fontSize: 16,decoration: TextDecoration.underline,color: Theme.of(context).accentColor),
                                ),
                              ],
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
