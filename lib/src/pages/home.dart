import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/home_controller.dart';
import '../elements/CardsCarouselWidget.dart';
import '../elements/CaregoriesCarouselWidget.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/DeliveryAddressBottomSheetWidget.dart';
import '../elements/GridWidget.dart';
import '../elements/HomeSliderWidget.dart';
import '../elements/ProductsCarouselWidget.dart';
import '../elements/ReviewsListWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/SearchWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../helpers/helper.dart';
import '../repository/settings_repository.dart' as settingsRepo;
import '../repository/user_repository.dart';
import 'notifications.dart';
class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget> {
  HomeController _con;

  _HomeWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 200,
        leading:  Row(
          children: [

            IconButton(
              icon: new Icon(Icons.search, color: Theme.of(context).hintColor),
              onPressed: () =>
                  Navigator.of(context).push(SearchModal())
            ),
            ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),

          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,

        actions: <Widget>[

          IconButton(
            icon: new Icon(Icons.message_outlined, color: Theme.of(context).hintColor),
            onPressed: () =>
            currentUser.value.apiToken == null?Navigator.of(context).pushNamed('/Login'): Navigator.of(context)
                .pushNamed('/MessagesWidget'),
          ),
          IconButton(
            icon: new Icon(Icons.favorite_outline, color: Theme.of(context).hintColor),
            onPressed: () =>
            currentUser.value.apiToken == null?Navigator.of(context).pushNamed('/Login'): Navigator.of(context)
            .pushNamed('/Favorites'),
          ),
          IconButton(
            icon: new Icon(Icons.notifications_outlined, color: Theme.of(context).hintColor),
            onPressed: () =>
            currentUser.value.apiToken == null?Navigator.of(context).pushNamed('/Login'):  Navigator.of(context)
            .pushNamed('/Notification'),
          ),
          SizedBox(width: 15,)
        ],
      ),
      body: Stack(
        children: [
          backgroundImage(),
          RefreshIndicator(
            color: Theme.of(context).accentColor,
            onRefresh: _con.refreshHome,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child:
              _con.slides == null || _con.slides.isEmpty ||_con.categories.isEmpty ||_con.categories == null?
              CircularLoadingWidget(height: 800)
             : Column(children: [
               SizedBox(height: 100,),
                HomeSliderWidget(slides: _con.slides),
                CategoriesCarouselWidget(
                  categories: _con.categories,
                )
              ],)
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   mainAxisSize: MainAxisSize.min,
                  //   children:
                  //   List.generate(settingsRepo.setting.value.homeSections.length, (index) {
                  //     String _homeSection = settingsRepo.setting.value.homeSections.elementAt(index);
                  //
                  //     switch (_homeSection) {
                  //       case 'slider':
                  //         return HomeSliderWidget(slides: _con.slides);
                  //
                  //
                  //
                  //       // case 'search':
                  //       //   return Padding(
                  //       //     padding: const EdgeInsets.symmetric(horizontal: 20),
                  //       //     child: SearchBarWidget(
                  //       //       onClickFilter: (event) {
                  //       //         widget.parentScaffoldKey.currentState.openEndDrawer();
                  //       //       },
                  //       //     ),
                  //       //   );
                  //
                  //
                  //       // case 'top_markets_heading':
                  //       //   return Padding(
                  //       //     padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
                  //       //     child: Column(
                  //       //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       //       children: [
                  //       //         Row(
                  //       //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       //           children: [
                  //       //             Expanded(
                  //       //               child: Text(
                  //       //                 S.of(context).top_markets,
                  //       //                 style: Theme.of(context).textTheme.headline4,
                  //       //                 maxLines: 1,
                  //       //                 softWrap: false,
                  //       //                 overflow: TextOverflow.fade,
                  //       //               ),
                  //       //             ),
                  //       //             InkWell(
                  //       //               onTap: () {
                  //       //                 if (currentUser.value.apiToken == null) {
                  //       //                   _con.requestForCurrentLocation(context);
                  //       //                 } else {
                  //       //                   var bottomSheetController = widget.parentScaffoldKey.currentState.showBottomSheet(
                  //       //                     (context) => DeliveryAddressBottomSheetWidget(scaffoldKey: widget.parentScaffoldKey),
                  //       //                     shape: RoundedRectangleBorder(
                  //       //                       borderRadius: new BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  //       //                     ),
                  //       //                   );
                  //       //                   bottomSheetController.closed.then((value) {
                  //       //                     _con.refreshHome();
                  //       //                   });
                  //       //                 }
                  //       //               },
                  //       //               child: Container(
                  //       //                 padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  //       //                 decoration: BoxDecoration(
                  //       //                   borderRadius: BorderRadius.all(Radius.circular(5)),
                  //       //                   color: settingsRepo.deliveryAddress.value?.address == null
                  //       //                       ? Theme.of(context).focusColor.withOpacity(0.1)
                  //       //                       : Theme.of(context).accentColor,
                  //       //                 ),
                  //       //                 child: Text(
                  //       //                   S.of(context).delivery,
                  //       //                   style: TextStyle(
                  //       //                       color:
                  //       //                           settingsRepo.deliveryAddress.value?.address == null ? Theme.of(context).hintColor : Theme.of(context).primaryColor),
                  //       //                 ),
                  //       //               ),
                  //       //             ),
                  //       //             SizedBox(width: 7),
                  //       //             InkWell(
                  //       //               onTap: () {
                  //       //                 setState(() {
                  //       //                   settingsRepo.deliveryAddress.value?.address = null;
                  //       //                 });
                  //       //               },
                  //       //               child: Container(
                  //       //                 padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  //       //                 decoration: BoxDecoration(
                  //       //                   borderRadius: BorderRadius.all(Radius.circular(5)),
                  //       //                   color: settingsRepo.deliveryAddress.value?.address != null
                  //       //                       ? Theme.of(context).focusColor.withOpacity(0.1)
                  //       //                       : Theme.of(context).accentColor,
                  //       //                 ),
                  //       //                 child: Text(
                  //       //                   S.of(context).pickup,
                  //       //                   style: TextStyle(
                  //       //                       color:
                  //       //                           settingsRepo.deliveryAddress.value?.address != null ? Theme.of(context).hintColor : Theme.of(context).primaryColor),
                  //       //                 ),
                  //       //               ),
                  //       //             ),
                  //       //           ],
                  //       //         ),
                  //       //         if (settingsRepo.deliveryAddress.value?.address != null)
                  //       //           Padding(
                  //       //             padding: const EdgeInsets.only(top: 12),
                  //       //             child: Text(
                  //       //               S.of(context).near_to + " " + (settingsRepo.deliveryAddress.value?.address),
                  //       //               style: Theme.of(context).textTheme.caption,
                  //       //             ),
                  //       //           ),
                  //       //       ],
                  //       //     ),
                  //       //   );
                  //
                  //       // case 'categories_heading':
                  //       //   return Padding(
                  //       //     padding: const EdgeInsets.symmetric(horizontal: 20),
                  //       //     child: ListTile(
                  //       //       dense: true,
                  //       //       contentPadding: EdgeInsets.symmetric(vertical: 0),
                  //       //       leading: Icon(
                  //       //         Icons.category_outlined,
                  //       //         color: Theme.of(context).hintColor,
                  //       //       ),
                  //       //       title: Text(
                  //       //         'تصنيفات بيتوتي',
                  //       //         style: Theme.of(context).textTheme.headline4,
                  //       //       ),
                  //       //     ),
                  //       //   );
                  //       case 'categories':
                  //         return CategoriesCarouselWidget(
                  //           categories: _con.categories,
                  //         );
                  //       // case 'top_markets':
                  //       //   return CardsCarouselWidget(marketsList: _con.topMarkets, heroTag: 'home_top_markets');
                  //       // case 'trending_week_heading':
                  //       //   return ListTile(
                  //       //     dense: true,
                  //       //     contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  //       //     leading: Icon(
                  //       //       Icons.trending_up,
                  //       //       color: Theme.of(context).hintColor,
                  //       //     ),
                  //       //     title: Text(
                  //       //       S.of(context).trending_this_week,
                  //       //       style: Theme.of(context).textTheme.headline4,
                  //       //     ),
                  //       //     subtitle: Text(
                  //       //       S.of(context).clickOnTheProductToGetMoreDetailsAboutIt,
                  //       //       maxLines: 2,
                  //       //       style: Theme.of(context).textTheme.caption,
                  //       //     ),
                  //       //   );
                  //       // case 'trending_week':
                  //       //   return ProductsCarouselWidget(productsList: _con.trendingProducts, heroTag: 'home_product_carousel');
                  //       //
                  //       // case 'popular_heading':
                  //       //   return Padding(
                  //       //     padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  //       //     child: ListTile(
                  //       //       dense: true,
                  //       //       contentPadding: EdgeInsets.symmetric(vertical: 0),
                  //       //       leading: Icon(
                  //       //         Icons.trending_up,
                  //       //         color: Theme.of(context).hintColor,
                  //       //       ),
                  //       //       title: Text(
                  //       //         S.of(context).most_popular,
                  //       //         style: Theme.of(context).textTheme.headline4,
                  //       //       ),
                  //       //     ),
                  //       //   );
                  //       // case 'popular':
                  //       //   return Padding(
                  //       //     padding: const EdgeInsets.symmetric(horizontal: 20),
                  //       //     child: GridWidget(
                  //       //       marketsList: _con.popularMarkets,
                  //       //       heroTag: 'home_markets',
                  //       //     ),
                  //       //   );
                  //
                  //       default:
                  //         return SizedBox(height: 0);
                  //     }
                  //   }),
                  // ),

            ),
          ),
        ],
      ),
    );
  }
}
