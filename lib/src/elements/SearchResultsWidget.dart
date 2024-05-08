import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/search_controller.dart';
import '../elements/CardWidget.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/ProductItemWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';

class SearchResultWidget extends StatefulWidget {
  final String heroTag;

  SearchResultWidget({Key key, this.heroTag}) : super(key: key);

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends StateMVC<SearchResultWidget> {
  SearchController _con;

  _SearchResultWidgetState() : super(SearchController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          backgroundImage(),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 70, right: 2),
                child:
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                    Spacer(),
                        Text(
                          S.of(context).search,
                          style: Theme.of(context).textTheme.headline2
                        ),
                        Spacer(),



                    ],),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  onSubmitted: (text) async {
                    await _con.refreshSearch(text);
                    _con.saveSearch(text);
                  },
                  cursorColor:Theme.of(context).accentColor ,

                  // autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText:'ابحث عن الأسر المتتجة أو المنتجات',
                    hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                    prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).accentColor,
                    width: 2)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).accentColor,
                    width: 2)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).accentColor,
                    width: 2)),
                  ),
                ),
              ),
              // _con.markets.isEmpty && _con.products.isEmpty
              //     ? CircularLoadingWidget(height: 500)
              //     :
    Expanded(
                      child: ListView(
                        children: <Widget>[
                          _con.products.isEmpty?CircularLoadingWidget(height: 500):   ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.only(top: 0),
                            itemCount: _con.products.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 10);
                            },
                            itemBuilder: (context, index) {
                              return ProductItemWidget(
                                heroTag: 'search_list',
                                product: _con.products.elementAt(index),
                              );
                            },
                          ),
                          _con.markets.length>=1?
                          Divider(height: 50,color:Theme.of(context).hintColor, ):SizedBox(),
                          _con.markets.isEmpty
                          ?Column():ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.only(top: 0),
                            itemCount: _con.markets.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/Details',
                                      arguments: RouteArgument(
                                        id: '0',
                                        param: _con.markets.elementAt(index).id,
                                        heroTag: widget.heroTag,
                                      ));
                                },
                                child: CardWidget(market: _con.markets.elementAt(index), heroTag: widget.heroTag),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
