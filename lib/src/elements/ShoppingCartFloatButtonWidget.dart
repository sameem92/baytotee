import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/cart_controller.dart';
import '../models/route_argument.dart';
import '../repository/user_repository.dart';

class ShoppingCartFloatButtonWidget extends StatefulWidget {
  const ShoppingCartFloatButtonWidget({
    this.iconColor,
    this.labelColor,
    this.routeArgument,
    Key key,
  }) : super(key: key);

  final Color iconColor;
  final Color labelColor;
  final RouteArgument routeArgument;

  @override
  _ShoppingCartFloatButtonWidgetState createState() => _ShoppingCartFloatButtonWidgetState();
}

class _ShoppingCartFloatButtonWidgetState extends StateMVC<ShoppingCartFloatButtonWidget> {
  CartController _con;

  _ShoppingCartFloatButtonWidgetState() : super(CartController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForCartsCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (currentUser.value.apiToken != null) {
          Navigator.of(context).pushNamed('/Cart', arguments: widget.routeArgument);
        } else {
          Navigator.of(context).pushNamed('/Login');
        }
      },
      child: SizedBox(
        width: 60,
        height: 60,
        child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Icon(
                Icons.shopping_cart_outlined,
                color: this.widget.iconColor,
                size: 28,
              ),
              Positioned(
                bottom: 5,
                left: 15,
                child: Container(
                  child: Center(
                    child: Text(
                      _con.cartCount.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption.merge(
                            TextStyle(color: Theme.of(context).primaryColor, fontSize: 10),
                          ),
                    ),
                  ),
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(color: this.widget.labelColor, borderRadius: BorderRadius.all(Radius.circular(10))),
                  constraints: BoxConstraints(minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
                ),
              ),
            ],
          ),

      ),
    );
//    return MaterialButton(elevation:0,
//      onPressed: () {
//        print('to shopping cart');
//      },
//      child:
//      color: Colors.transparent,
//    );
  }
}
