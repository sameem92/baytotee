import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/order_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../helpers/helper.dart';
import '../repository/user_repository.dart';

class OrdersWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  OrdersWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends StateMVC<OrdersWidget> {
  OrderController _con;

  _OrdersWidgetState() : super(OrderController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).my_orders,
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1)),
        ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: _con.orders.isEmpty
          ? CircularLoadingWidget(height: 800)
          : Stack(
              children: [
                backgroundImage(),
                RefreshIndicator(
                  color: Theme.of(context).accentColor,
                  onRefresh: _con.refreshOrders,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(height: 20),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: _con.orders.length,
                          itemBuilder: (context, index) {
                            var _order = _con.orders.elementAt(index);
                            return

                              Column(
                                children: [
                                  OrderItemWidget(
                                  expanded:

                                  // _con.orders[index].active &&_con.orders[index].orderStatus.status!='تم التوصيل'
                                  // &&index <=6

                                  _con.orders[0].active &&_con.orders[0].orderStatus.status!='تم التوصيل'  ?  index == 0 :
                                  _con.orders[1].active &&_con.orders[1].orderStatus.status!='تم التوصيل'  ?  index == 1 :
                                  _con.orders[2].active &&_con.orders[2].orderStatus.status!='تم التوصيل'  ?  index == 2 :
                                  _con.orders[3].active &&_con.orders[3].orderStatus.status!='تم التوصيل'  ?  index == 3 :
                                  _con.orders[4].active &&_con.orders[4].orderStatus.status!='تم التوصيل'  ?  index == 4 :
                                  _con.orders[5].active &&_con.orders[5].orderStatus.status!='تم التوصيل'  ?  index == 5 :
                                  index == 6
                                    ? true : false,
                                  // expanded: _con.orders[index].active ? true : false,

                                  order: _order,
                                  onCanceled: (e) {
                                    _con.doCancelOrder(_order);
                                  },
                            )
                                ],
                              )


                            ;
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 30);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
