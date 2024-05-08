import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../controllers/cart_controller.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';

class CartBottomDetailsWidget extends StatelessWidget {
  const CartBottomDetailsWidget({
    Key key,
    @required CartController con,
  })  : _con = con,
        super(key: key);

  final CartController _con;

  @override
  Widget build(BuildContext context) {
    return _con.carts.isEmpty
        ? SizedBox(height: 0)
        : Container(
            height: 200,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), offset: Offset(0, -2), blurRadius: 5.0)]),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'المجموع',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Helper.getPrice(_con.subTotal, context, style: Theme.of(context).textTheme.subtitle1, zeroPlaceholder: '0')
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          S.of(context).delivery_fee,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      if (Helper.canDelivery(_con.carts[0].product.market, carts: _con.carts))
                        Helper.getPrice(_con.carts[0].product.market.deliveryFee, context, style: Theme.of(context).textTheme.subtitle1, zeroPlaceholder: S.of(context).free)
                      else
                        Helper.getPrice(0, context, style: Theme.of(context).textTheme.subtitle1, zeroPlaceholder: S.of(context).free)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${S.of(context).tax}              (${_con.carts[0].product.market.defaultTax}%)',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Helper.getPrice(_con.taxAmount, context, style: Theme.of(context).textTheme.subtitle1)
                    ],
                  ),
                  SizedBox(height: 10),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushNamed('/Details',
                                  arguments: RouteArgument(
                                    id: '0',
                                    param: _con.carts[0].product.market.id,
                                    // heroTag: _con.carts[0].heroTag,
                                  ));
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Theme.of(context).accentColor ,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(child: Row(
                                children: [
                                  Icon(Icons.turn_left,color: Colors.white,),
                                  Flexible(
                                    child: Text(
                                      _con.carts[0].product.market.name,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color:Colors.white,
                                      ),
                                      // style: Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                ],
                              )),
                            )
                        ),
                      ),
                     SizedBox(width: 20,),
                     Expanded(
                       child: GestureDetector(
                            onTap: (){
                              _con.goCheckout(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(color: !_con.carts[0].product.market.closed ? Theme.of(context).accentColor : Theme.of(context).focusColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                Text('الدفع',style: TextStyle(color: Colors.white),),
                                Helper.getPrice(_con.total, context,
                                    style: Theme.of(context).textTheme.headline4.merge(TextStyle(color: Theme.of(context).primaryColor)), zeroPlaceholder: 'Free'),

                              ],),
                            )
                          ),
                     ),

                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
  }
}
