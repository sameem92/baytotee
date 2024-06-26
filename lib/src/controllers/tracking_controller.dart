import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/order.dart';
import '../models/order_status.dart';
import '../repository/order_repository.dart';

class TrackingController extends ControllerMVC {
  Order order;
  List<OrderStatus> orderStatus = <OrderStatus>[];
  GlobalKey<ScaffoldState> scaffoldKey;

  TrackingController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void listenForOrder({String orderId, String message}) async {
    final Stream<Order> stream = await getOrder(orderId);
    stream.listen((Order _order) {
      setState(() {
        order = _order;
      });
    }, onError: (a) {
      print(a);
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(
          snackBar_baytoty(S.of(state.context).verify_your_internet_connection)
      );

    }, onDone: () {
      listenForOrderStatus();
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(snackBar_baytoty(
            message)
        );
      }
    });
  }

  void listenForOrderStatus() async {
    final Stream<OrderStatus> stream = await getOrderStatus();
    stream.listen((OrderStatus _orderStatus) {
      setState(() {
        orderStatus.add(_orderStatus);
      });
    }, onError: (a) {}, onDone: () {});
  }

  List<Step> getTrackingSteps(BuildContext context) {
    List<Step> _orderStatusSteps = [];
    this.orderStatus.forEach((OrderStatus _orderStatus) {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Center(
          child: Text(
            _orderStatus.status,
            style: Theme.of(state.context).textTheme.subtitle1.merge(TextStyle(color: order.orderStatus.id == _orderStatus.id?
            Theme.of(context).accentColor:Colors.black87)),
          ),
        ),
        subtitle: order.orderStatus.id == _orderStatus.id
            ? Center(
              child: Text(
                  '${DateFormat('HH:mm | yyyy-MM-dd').format(order.dateTime)}',
                  style: Theme.of(state.context).textTheme.caption,
                  overflow: TextOverflow.ellipsis,
                ),
            )
            : SizedBox(height: 0),
        content: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                '${Helper.skipHtml(order.hint)}',
              ),
            )),
        isActive: (int.tryParse(order.orderStatus.id)) >= (int.tryParse(_orderStatus.id)),
      ));
    });
    return _orderStatusSteps;
  }

  Future<void> refreshOrder() async {
    order = new Order();
    listenForOrder(message: S.of(state.context).tracking_refreshed_successfuly);
  }

  void doCancelOrder() {
    cancelOrder(this.order).then((value) {
      setState(() {
        this.order.active = false;
      });
    }).catchError((e) {
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(
          snackBar_baytoty(
              e)
      );

    }).whenComplete(() {
      orderStatus = [];
      listenForOrderStatus();
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(
          snackBar_baytoty(S.of(state.context).orderThisorderidHasBeenCanceled(this.order.id))
      );

    });
  }

  bool canCancelOrder(Order order) {
    return order.active == true && order.orderStatus.id == 1;
  }
}
