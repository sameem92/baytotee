import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/cart_controller.dart';
import '../elements/CartBottomDetailsWidget.dart';
import '../elements/CartItemWidget.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/EmptyCartWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

class CartWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  CartWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends StateMVC<CartWidget> {
  CartController _con;

  _CartWidgetState() : super(CartController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForCarts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,

      child: Scaffold(
extendBodyBehindAppBar: true,
        key: _con.scaffoldKey,
        bottomNavigationBar:_con.carts.isEmpty?SizedBox(): CartBottomDetailsWidget(con: _con),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              // if (widget.routeArgument != null) {
              //   Navigator.of(context).pushReplacementNamed(widget.routeArgument.param, arguments: RouteArgument(id: widget.routeArgument.id));
              // } else {
              //   Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1);
              // }
            },
            icon: Icon(Icons.arrow_back),
            color: Theme.of(context).accentColor,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'سلة الشراء',
            style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1)),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _con.refreshCarts,

          color: Theme.of(context).accentColor,
          child: _con.carts.isEmpty
              ? CircularLoadingWidget(height: 800)
              : Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    backgroundImage(),
                    ListView(
                      primary: true,
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [

                            Icon(
                             Icons.family_restroom,
                              color: Theme.of(context).accentColor,
                              ),
                            SizedBox(width: 20,),
                            
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushNamed('/Details',
                                    arguments: RouteArgument(
                                      id: '0',
                                      param: _con.carts[0].product.market.id,
                                      // heroTag: _con.carts[0].heroTag,
                                    ));
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.turn_left,color: Theme.of(context).accentColor,),

                                  Text(
                                        _con.carts[0].product.market.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(decoration: TextDecoration.underline,color: Theme.of(context).accentColor,
                                        fontSize: 16

                                        ),
                                        // style: Theme.of(context).textTheme.headline4,
                                      ),
                                ],
                              ),
                            ),

                          ],)

                          // ListTile(
                          //   contentPadding: EdgeInsets.symmetric(vertical: 0),
                          //   leading: Icon(
                          //     Icons.shopping_cart_outlined,
                          //     color: Theme.of(context).hintColor,
                          //   ),
                          //   title: Text(
                          //     _con.carts[0].product.market.name,
                          //     maxLines: 1,
                          //     overflow: TextOverflow.ellipsis,
                          //     style: Theme.of(context).textTheme.headline4,
                          //   ),
                          //   subtitle: Text(
                          //     S.of(context).verify_your_quantity_and_click_checkout,
                          //     maxLines: 1,
                          //     overflow: TextOverflow.ellipsis,
                          //     style: Theme.of(context).textTheme.caption,
                          //   ),
                          // ),
                        ),
                        ListView.separated(
                          padding: EdgeInsets.only(top: 15, bottom: 120),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: _con.carts.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 15);
                          },
                          itemBuilder: (context, index) {
                            return CartItemWidget(
                              cart: _con.carts.elementAt(index),
                              heroTag: 'cart',
                              increment: () {
                                _con.incrementQuantity(_con.carts.elementAt(index));
                              },
                              decrement: () {
                                _con.decrementQuantity(_con.carts.elementAt(index));
                              },
                              onDismissed: () {
                                _con.removeFromCart(_con.carts.elementAt(index));
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      margin: EdgeInsets.only(bottom: 15,left: 30,right: 30),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15),
                              offset: Offset(0, 2), blurRadius: 5.0)]),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        onSubmitted: (String value) {
                          _con.doApplyCoupon(value);
                        },
                        cursorColor: Theme.of(context).accentColor,
                        controller: TextEditingController()..text = coupon?.code ?? '',
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                          suffixText: coupon?.valid == null ? '' : (coupon.valid ?
                          'تم تفعيل الكوبون': "غير موجود"),
                          // suffixStyle: Theme.of(context).textTheme.caption.merge(TextStyle(color: _con.getCouponIconColor())),
                          // suffixIcon: Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 15),
                          //   child: Icon(
                          //     Icons.confirmation_num_outlined,
                          //     color: ,
                              // color: _con.getCouponIconColor(),
                          //     size: 28,
                          //   ),
                          // ),
                          hintText:'أدخل كوبون الخصم هنا',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
