import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/category_controller.dart';
import '../elements/AddToCartAlertDialog.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/DrawerWidget.dart';
import '../elements/FilterWidget.dart';
import '../elements/ProductGridItemWidget.dart';
import '../elements/ProductListItemWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../repository/user_repository.dart';

class CategoryWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  CategoryWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends StateMVC<CategoryWidget> {
  // TODO add layout in configuration file
  String layout = 'grid';

  CategoryController _con;

  _CategoryWidgetState() : super(CategoryController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForProductsByCategory(id: widget.routeArgument.id);
    _con.listenForCategory(id: widget.routeArgument.id);
    _con.listenForCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      extendBodyBehindAppBar: true,
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
          _con.category?.name ?? '',
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 0)),
        ),
        actions: <Widget>[
          _con.loadCart
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.5, vertical: 15),
                  child: SizedBox(
                    width: 26,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                    ),
                  ),
                )
              : ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),

      body: Stack(
        children: [
          backgroundImage(),
          RefreshIndicator(
            color: Theme.of(context).accentColor,
            onRefresh: _con.refreshCategory,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(height: 100),
                  _con.products.isEmpty
                      ? CircularLoadingWidget(height: 800)
                      : Offstage(
                          offstage: this.layout != 'grid',
                          child: GridView.count(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            // crossAxisSpacing: 2,
                            mainAxisSpacing: 10,
                            padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                            // Create a grid with 2 columns. If you change the scrollDirection to
                            // horizontal, this produces 2 rows.
                            crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 1 : 1,
                            // Generate 100 widgets that display their index in the List.
                            children: List.generate(_con.products.length, (index) {
                              return ProductGridItemWidget(
                                  heroTag: 'category_grid',
                                  product: _con.products.elementAt(index),
                                  // onPressed: () {
    //                                 if (currentUser.value.apiToken == null) {
    //                                   Navigator.of(context).pushNamed('/Login');
    //                                 } else {
    // if (_con.isSameMarkets(_con.products.elementAt(index))) {
    //                                   _con.addToCart(_con.products.elementAt(index),);
    // }else{
    //   _con.addToCart(_con.products.elementAt(index),reset: true);
    //
    // }

                                      // if (_con.isSameMarkets(_con.products.elementAt(index))) {
                                      //   _con.addToCart(_con.products.elementAt(index));
                                      // } else {
                                      //   showDialog(
                                      //     context: context,
                                      //     builder: (BuildContext context) {
                                      //       // return object of type Dialog
                                      //       return AddToCartAlertDialogWidget(
                                      //           oldProduct: _con.carts.elementAt(0)?.product,
                                      //           newProduct: _con.products.elementAt(index),
                                      //           onPressed: (product, {reset = true}) {
                                      //             return _con.addToCart(_con.products.elementAt(index), reset: true);
                                      //           });
                                      //     },
                                      //   );
                                      // }

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
