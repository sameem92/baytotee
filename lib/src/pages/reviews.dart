import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/reviews_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';

class ReviewsWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  ReviewsWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _ReviewsWidgetState createState() {
    return _ReviewsWidgetState();
  }
}

class _ReviewsWidgetState extends StateMVC<ReviewsWidget> {
  ReviewsController _con;

  _ReviewsWidgetState() : super(ReviewsController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForOrder(orderId: widget.routeArgument.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).accentColor,
              )),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "تقييم الطلب",
            style: Theme.of(context)
                .textTheme
                .headline6
                .merge(TextStyle(letterSpacing: 1)),
          ),
        ),
        body: RefreshIndicator(
            color: Theme.of(context).accentColor,
            onRefresh: _con.refreshOrder,
            child: _con.order == null
                ? CircularLoadingWidget(height: 800)
                : Stack(
                    children: [
                      backgroundImage(),
                      SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 110,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.15),
                                        offset: Offset(0, -2),
                                        blurRadius: 5.0)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                      _con.order.productOrders[0].product.market
                                          .name,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(5, (index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            _con.marketReview.rate =
                                                (index + 1).toString();
                                          });
                                        },
                                        child: index <
                                                int.parse(
                                                    _con.marketReview.rate)
                                            ? Icon(Icons.star,
                                                size: 30,
                                                color: Color(0xFFFFB24D))
                                            : Icon(Icons.star_border,
                                                size: 30,
                                                color: Color(0xFFFFB24D)),
                                      );
                                    }),
                                  ),
                                  SizedBox(height: 10),
                                  TextField(
                                    onChanged: (text) {
                                      _con.marketReview.review = text;
                                    },
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    cursorColor: Theme.of(context).accentColor,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(12),
                                      hintText: "تعليقك على الخدمة",
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .merge(TextStyle(fontSize: 14)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.1))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.2))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(0.1))),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  TextButton(
                                    child: Text(
                                      "تقييم الأسرة",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 30)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Theme.of(context).accentColor),
                                        shape: MaterialStateProperty.all(
                                            StadiumBorder()),
                                        side: MaterialStateProperty.all(BorderSide(
                                            color:
                                                Theme.of(context).accentColor)),
                                        textStyle: MaterialStateProperty.all(
                                            TextStyle(
                                                color: Theme.of(context).primaryColor))),
                                    onPressed: () {
                                      if (_con.marketReview.review !=
                                              null ||
                                          _con.marketReview.rate !=
                                              "0") {
                                        _con.addMarketReview(_con.marketReview);
                                      }
                                      print(_con.marketReview.review);
                                      print(_con.marketReview.rate);
                                      FocusScope.of(context).unfocus();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: List.generate(
                                  _con.productsOfOrder.length, (index) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.15),
                                            offset: Offset(0, -2),
                                            blurRadius: 5.0)
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Text(_con.productsOfOrder[index].name,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(5, (star) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                _con.productsReviews[index]
                                                        .rate =
                                                    (star + 1).toString();
                                              });
                                            },
                                            child: star <
                                                    int.parse(_con
                                                        .productsReviews[index]
                                                        .rate)
                                                ? Icon(Icons.star,
                                                    size: 30,
                                                    color: Color(0xFFFFB24D))
                                                : Icon(Icons.star_border,
                                                    size: 30,
                                                    color: Color(0xFFFFB24D)),
                                          );
                                        }),
                                      ),
                                      SizedBox(height: 5),
                                      TextField(
                                        onChanged: (text) {
                                          _con.productsReviews[index].review =
                                              text;
                                        },
                                        maxLines: 2,
                                        cursorColor:
                                            Theme.of(context).accentColor,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(12),
                                          hintText: "تعليقك على المنتج",
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .merge(TextStyle(fontSize: 14)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .focusColor
                                                      .withOpacity(0.1))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .focusColor
                                                      .withOpacity(0.2))),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.1),
                                              )),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      TextButton(
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 30)),
                                            backgroundColor: MaterialStateProperty.all(
                                                Theme.of(context).accentColor),
                                            shape: MaterialStateProperty.all(
                                                StadiumBorder()),
                                            side: MaterialStateProperty.all(
                                                BorderSide(
                                                    color: Theme.of(context)
                                                        .accentColor)),
                                            textStyle: MaterialStateProperty.all(
                                                TextStyle(color: Theme.of(context).primaryColor))),
                                        onPressed: () {
                                          if (_con.productsReviews[index]
                                                      .review !=
                                                  null ||
                                              _con.productsReviews[index]
                                                      .rate !=
                                                  "0") {
                                            _con.addProductReview(
                                                _con.productsReviews[index],
                                                _con.productsOfOrder[index]);
                                            FocusScope.of(context).unfocus();
                                          }
                                          print(_con
                                              .productsReviews[index].review);
                                          print(
                                              _con.productsReviews[index].rate);
                                        },
                                        child: Text(
                                          "تقييم المنتج",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  )));
  }
}
