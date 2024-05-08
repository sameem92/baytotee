import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/product_controller.dart';
import '../elements/AddToCartAlertDialog.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/OptionItemWidget.dart';
import '../elements/ReviewsListWidget.dart';
import '../elements/ShoppingCartFloatButtonWidget.dart';
import '../helpers/helper.dart';
import '../models/media.dart';
import '../models/route_argument.dart';
import '../repository/user_repository.dart';

// ignore: must_be_immutable
class ProductWidget extends StatefulWidget {
  RouteArgument routeArgument;

  ProductWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _ProductWidgetState createState() {
    return _ProductWidgetState();
  }
}

class _ProductWidgetState extends StateMVC<ProductWidget> {
  ProductController _con;

  _ProductWidgetState() : super(ProductController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForProduct(productId: widget.routeArgument.id);
    _con.listenForCart();
    _con.listenForFavorite(productId: widget.routeArgument.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: _con.product == null || _con.product?.image == null || _con.product?.images == null
          ? CircularLoadingWidget(height: 800)
          : Stack(
            children: [
              backgroundImage(),
              RefreshIndicator(
                color: Theme.of(context).accentColor,
                  onRefresh: _con.refreshProduct,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 125),
                        padding: EdgeInsets.only(bottom: 15),
                        child: CustomScrollView(
                          primary: true,
                          shrinkWrap: false,
                          slivers: <Widget>[
                            SliverAppBar(
                              backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                              expandedHeight: 275,
                              elevation: 0,
                              actions: [

                                _con.loadCart
                                    ? SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: RefreshProgressIndicator(),
                                )
                                    : ShoppingCartFloatButtonWidget(
                                  iconColor: Theme.of(context).primaryColor,
                                  labelColor: Theme.of(context).hintColor,
                                  routeArgument: RouteArgument(param: '/Product', id: _con.product.id),
                                ),


                                GestureDetector(
                                  onTap: (){
                                    _con.favorite?.id != null?
                                    _con.removeFromFavorite(_con.favorite):
                                    currentUser.value.apiToken == null?
                                      Navigator.of(context).pushNamed("/Login"):

                                      _con.addToFavorite(_con.product);
                                  },
                                  child: Icon(
                                    _con.favorite?.id != null? Icons.favorite:Icons.favorite_outline,
                                    color:_con.favorite?.id != null? Theme.of(context).primaryColor:Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(width: 10,),
                              ],
                              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),

                            ),
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                child: Wrap(
                                  runSpacing: 8,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                _con.product?.name ?? '',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: Theme.of(context).textTheme.headline2,
                                              ),

                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child:

                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              _con.product.discountPrice > 0
                                                  ? Helper.getPrice(
                                                  _con.product.discountPrice, context,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough)))
                                                  : SizedBox(height: 0),
                                              Helper.getPrice(
                                                _con.product.price,
                                                context,
                                                // style:
                                                //     Theme.of(context).textTheme.headline6,
                                              ),
                                            ],
                                          ),


                                          // Row(
                                          //   crossAxisAlignment: CrossAxisAlignment.end,
                                          //   mainAxisAlignment: MainAxisAlignment.end,
                                          //   children: <Widget>[
                                          //     Helper.getPrice(
                                          //       _con.product.price,
                                          //       context,
                                          //       style: Theme.of(context).textTheme.headline2,
                                          //     ),
                                          //     _con.product.discountPrice > 0
                                          //         ? Helper.getPrice(_con.product.discountPrice, context,
                                          //             style: Theme.of(context).textTheme.bodyText2.
                                          //             merge(TextStyle(decoration: TextDecoration.lineThrough)))
                                          //         : SizedBox(height: 0),
                                          //   ],
                                          // ),
                                        ),
                                      ],
                                    ),
                                    Divider(height: 20,color:Theme.of(context).accentColor ,),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        GestureDetector(
                                          onTap: (){
                                            Navigator.of(context).pushNamed('/Details', arguments:
                                            RouteArgument(id: '0', param: _con.product?.market?.id));

                                            // _con.product?.market?.id
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.turn_left,color: Theme.of(context).accentColor,),
                                              Text(
                                                "الأسرة  : ${_con.product?.market?.name ?? ''}",
                                                // overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                          style:TextStyle(fontSize: 14,decoration: TextDecoration.underline,color: Theme.of(context).accentColor),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text( _con.product?.market?.rate, style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Theme.of(context).accentColor))),
                                            Icon(
                                              Icons.star_border,
                                              color: Theme.of(context).accentColor,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    Divider(height: 20,color:Theme.of(context).accentColor ,),
                                    Text(Helper.skipHtml(_con.product.description)),

                                    Divider(height: 20,color:Theme.of(context).accentColor ,),

                                    _con.product.productReviews.length>=1?ReviewsListWidget(
                                      reviewsList: _con.product.productReviews,
                                    ):Column(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), offset: Offset(0, -2), blurRadius: 5.0)]),
                          child:
                                Row(
                                  children: <Widget>[
                                    Row(
                                      // mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(width: 20,),

                                        IconButton(
                                          onPressed: () {
                                            _con.decrementQuantity();
                                          },
                                          iconSize: 30,
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                          icon: Icon(Icons.remove_circle_outline),
                                          color: Theme.of(context).accentColor,
                                        ),
                                        Text(_con.quantity.toString(), style: Theme.of(context).textTheme.headline6),
                                        IconButton(
                                          onPressed: () {
                                            _con.incrementQuantity();
                                          },
                                          iconSize: 30,
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                          icon: Icon(Icons.add_circle_outline),
                                          color: Theme.of(context).accentColor,
                                        )
                                      ],
                                    ),

                                    Expanded(
                                      child: Stack(
                                        // fit: StackFit.loose,
                                        alignment: AlignmentDirectional.centerEnd,
                                        children: <Widget>[

                                          SizedBox(
                                            width: MediaQuery.of(context).size.width - 160,
                                            height: double.infinity,
                                            child: MaterialButton(
                                              elevation: 0,
                                              onPressed: () {
                                                if (currentUser.value.apiToken == null) {
                                                  Navigator.of(context).pushNamed("/Login");
                                                } else {
                                                  if (_con.isSameMarkets(_con.product)) {
                                                    _con.addToCart(_con.product);
                                                  } else {

                                                    _con.addToCart(_con.product,
                                                        reset: true);

                                                  }}
                                                  // if (_con.isSameMarkets(_con.product)) {
                                                  //   _con.addToCart(_con.product);
                                                  // } else {
                                                  //   showDialog(
                                                  //     context: context,
                                                  //     builder: (BuildContext context) {
                                                  //       // return object of type Dialog
                                                  //       return AddToCartAlertDialogWidget(
                                                  //           oldProduct: _con.carts.elementAt(0)?.product,
                                                  //           newProduct: _con.product,
                                                  //           onPressed: (product, {reset = true}) {
                                                  //             return _con.addToCart(_con.product, reset: true);
                                                  //           });
                                                  //     },
                                                  //   );
                                                  // }

                                              },
                                              padding: EdgeInsets.symmetric(vertical: 14),
                                              color: Theme.of(context).accentColor,
                                              // shape: StadiumBorder(),
                                              child: Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      S.of(context).add_to_cart,
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(color: Theme.of(context).primaryColor),
                                                    ),
                                                    Text(
                                                      "الشراء يكون من نفس الأسرة",
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 12,
                                                      fontWeight: FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: Helper.getPrice(
                                              _con.total,
                                              context,
                                              style: Theme.of(context).textTheme.headline4.merge(TextStyle(color: Theme.of(context).primaryColor)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),


                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
    );
  }
}
