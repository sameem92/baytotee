import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/l10n.dart';
import '../controllers/market_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/GalleryCarouselWidget.dart';
import '../elements/ProductItemWidget.dart';
import '../elements/ReviewsListWidget.dart';
import '../elements/ShoppingCartFloatButtonWidget.dart';
import '../helpers/helper.dart';
import '../models/conversation.dart';
import '../models/market.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';

class MarketWidget extends StatefulWidget {
  final RouteArgument routeArgument;
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  MarketWidget({Key key, this.parentScaffoldKey, this.routeArgument}) : super(key: key);

  @override
  _MarketWidgetState createState() {
    return _MarketWidgetState();
  }
}

class _MarketWidgetState extends StateMVC<MarketWidget> {
  MarketController _con;
  List<String> selectedCategories;
  _MarketWidgetState() : super(MarketController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.market = widget.routeArgument.param as Market;
    _con.listenForGalleries(_con.market.id);
    _con.listenForFeaturedProducts(_con.market.id);
    _con.listenForMarketReviews(id: _con.market.id);
    _con.market = widget.routeArgument.param as Market;
    _con.listenForTrendingProducts(_con.market.id);
    _con.listenForCategories(_con.market.id);
    selectedCategories = ['0'];
    _con.listenForProducts(_con.market.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        body: RefreshIndicator(
          color: Theme.of(context).accentColor,
          onRefresh: _con.refreshMarket,
          child: _con.market == null
              ? CircularLoadingWidget(height: 800)
              : Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    backgroundImage(),
                    CustomScrollView(
                      primary: true,
                      shrinkWrap: false,
                      slivers: <Widget>[
                        SliverAppBar(
                          backgroundColor: Colors.transparent,
                          expandedHeight: 300,
                          elevation: 0,
                          automaticallyImplyLeading: true,
                          leading: GestureDetector(
                              onTap: (){
                                Navigator.of(context).pop();
                              }
                              ,child: Icon(Icons.arrow_back_ios,color:Theme.of(context).accentColor ,)),

                          actions: [
                            ShoppingCartFloatButtonWidget(
                                iconColor: Theme.of(context).accentColor,
                                labelColor: Theme.of(context).hintColor,
                                routeArgument: RouteArgument(id: '0', param: _con.market.id, heroTag: 'home_slide')),
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background:
                            Column(
                              children: [
                                SizedBox(height: 100,),
                                ImageThumbCarouselWidget(galleriesList: _con.galleries),
                              ],
                            ),

                            // Hero(
                            //   tag: (widget?.routeArgument?.heroTag ?? '') + _con.market.id,
                            //   child: CachedNetworkImage(
                            //     fit: BoxFit.cover,
                            //     imageUrl: _con.market.image.url,
                            //     placeholder: (context, url) => Image.asset(
                            //       'assets/img/loading.gif',
                            //       fit: BoxFit.cover,
                            //     ),
                            //     errorWidget: (context, url, error) => Icon(Icons.error_outline),
                            //   ),
                            // ),
                          ),
                        ),



                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 25),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          _con.market?.name ?? '',
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          maxLines: 2,
                                          style: Theme.of(context).textTheme.headline2,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 32,
                                        child: Chip(
                                          padding: EdgeInsets.all(0),
                                          label: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(_con.market.rate, style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Theme.of(context).accentColor))),
                                              Icon(
                                                Icons.star_border,
                                                color: Theme.of(context).accentColor,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                          backgroundColor: Colors.transparent,

                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                      MaterialButton(
                                        elevation: 0,
                                        padding: EdgeInsets.all(0),
                                        disabledColor: Theme.of(context).focusColor.withOpacity(0.5),
                                        onPressed: currentUser.value.apiToken != null
                                            ? () {

                                          Navigator.of(context).pushNamed('/Chat',
                                              arguments: RouteArgument(
                                                  param: new Conversation(
                                                      _con.market.users.map((e) {
                                                        e.image = _con.market.image;
                                                        return e;
                                                      }).toList(),
                                                      name: _con.market.name)));
                                        }
                                            : null,
                                        child: Icon(
                                          Icons.chat_outlined,
                                          color: Theme.of(context).primaryColor,
                                          size: 24,
                                        ),
                                        color: Theme.of(context).accentColor.withOpacity(0.9),
                                        shape: StadiumBorder(),
                                      ),
                                      MaterialButton(
                                        elevation: 0,
                                        padding: EdgeInsets.all(0),
                                        onPressed: () {
                                          launch("tel:${_con.market.mobile}");
                                        },
                                        child: Icon(
                                          Icons.call_outlined,
                                          color: Theme.of(context).primaryColor,
                                          size: 24,
                                        ),
                                        color: Theme.of(context).accentColor.withOpacity(0.9),
                                        shape: StadiumBorder(),
                                      ),
                                    ],)
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                           child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(color: Colors.white,
                                        borderRadius: BorderRadius.circular(30)
                                        ,boxShadow: [BoxShadow(color:  Theme.of(context).hintColor.withOpacity(.2),
                                            blurRadius: 10,spreadRadius: 2),]

                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      child: Helper.applyHtml(context, _con.market.description),
                                    ),
                                  ),
                                ),
                                Divider(height: 20,color:Theme.of(context).accentColor ,),

                                _con.categories.isEmpty
                                    ? SizedBox(height: 0)
                                    : Container(
                                  height: 50,
                                  child: ListView(
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: List.generate(_con.categories.length, (index) {
                                      var _category = _con.categories.elementAt(index);
                                      var _selected = this.selectedCategories.contains(_category.id);
                                      return Padding(
                                        padding: const EdgeInsetsDirectional.only(start: 5),
                                        child: RawChip(
                                          elevation: 0,
                                          label: Text(_category.name,style: TextStyle(color: _selected?Colors.white:Theme.of(context).accentColor),),
                                          labelStyle: _selected
                                              ? Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Theme.of(context).primaryColor))
                                              : Theme.of(context).textTheme.bodyText2,
                                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                          backgroundColor: Theme.of(context).focusColor.withOpacity(0.1),
                                          selectedColor: Theme.of(context).accentColor,
                                          selected: _selected,
                                          showCheckmark: false,
                                          onSelected: (bool value) {
                                            setState(() {
                                              if (_category.id == '0') {
                                                this.selectedCategories = ['0'];
                                              } else {
                                                this.selectedCategories.removeWhere((element) => element == '0');
                                              }
                                              if (value) {
                                                this.selectedCategories.add(_category.id);
                                              } else {
                                                this.selectedCategories.removeWhere((element) => element == _category.id);
                                              }
                                              _con.selectCategory(this.selectedCategories);
                                            });
                                          },
                                        ),
                                      );
                                    }),
                                  ),
                                ),

                                _con.products.isEmpty
                                    ? CircularLoadingWidget(height: 0)
                                    : ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  primary: false,
                                  padding: EdgeInsets.only(top: 10),
                                  itemCount: _con.products.length,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 10);
                                  },
                                  itemBuilder: (context, index) {

                                    return ProductItemWidget(
                                      heroTag: 'menu_list',
                                      product: _con.products.elementAt(index),
                                    );
                                  },
                                ),



                                Divider(height: 30,color:Theme.of(context).accentColor ,),

                                _con.reviews.isEmpty
                                    ? SizedBox(height: 5)
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        child: ReviewsListWidget(reviewsList: _con.reviews),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
        ));
  }
}
