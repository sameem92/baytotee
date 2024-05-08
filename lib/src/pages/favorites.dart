import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/favorite_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/FavoriteGridItemWidget.dart';
import '../elements/FavoriteListItemWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../helpers/helper.dart';
import '../repository/user_repository.dart';

class FavoritesWidget extends StatefulWidget {
  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends StateMVC<FavoritesWidget> {
  String layout = 'grid';

  FavoriteController _con;

  _FavoritesWidgetState() : super(FavoriteController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      key: _con.scaffoldKey,
      appBar: AppBar(
          leading: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              }
              ,child: Icon(Icons.arrow_back_ios,color:Theme.of(context).accentColor ,)),

        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).favorites,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1)),
        ),
          ),
      body:
      Stack(
            children: [
              backgroundImage(),
              RefreshIndicator(
                color: Theme.of(context).accentColor,
                  onRefresh: _con.refreshFavorites,
                  child:_con.favorites.isEmpty?

                  CircularLoadingWidget(height: 800)
                  :SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(height: 100,),
                        Offstage(
                                offstage: this.layout != 'grid',
                                child: GridView.count(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  primary: false,

                                  mainAxisSpacing: 20,
                                  padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20
                                  ),
                                  // Create a grid with 2 columns. If you change the scrollDirection to
                                  // horizontal, this produces 2 rows.
                                  crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 1 : 2,
                                  // Generate 100 widgets that display their index in the List.
                                  children: List.generate(_con.favorites.length, (index) {
                                    return FavoriteGridItemWidget(
                                      heroTag: 'favorites_grid',
                                      favorite: _con.favorites.elementAt(index),
                                    );
                                  }),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
            ],
          ),
    );
  }
}
