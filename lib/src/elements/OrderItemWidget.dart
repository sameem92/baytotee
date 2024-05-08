import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../generated/l10n.dart';
import '../controllers/reviews_controller.dart';
import '../helpers/helper.dart';
import '../models/order.dart';
import '../models/review.dart';
import '../models/route_argument.dart';
import 'ProductOrderItemWidget.dart';

class OrderItemWidget extends StatefulWidget {
  final bool expanded;
  final Order order;
  final ValueChanged<void> onCanceled;

  OrderItemWidget({Key key, this.expanded, this.order, this.onCanceled})
      : super(key: key);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Opacity(
              opacity: widget.order.active ? 1 : .4,
              child: Container(
                margin: EdgeInsets.only(top: 14),
                padding: EdgeInsets.only(top: 20, bottom: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).focusColor.withOpacity(0.3),
                        blurRadius: 1,

                        offset: Offset(1, 2)),
                  ],
                ),
                child: Theme(

                  data: theme,
                  child: ExpansionTile(

                    initiallyExpanded: widget.expanded,
                    backgroundColor: Colors.white,

                    title: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    "تاريخ الطلب  :   ",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    DateFormat('dd-MM-yyyy | HH:mm')
                                        .format(widget.order.dateTime),
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(

                                    child:
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).pushNamed('/Details',
                                            arguments: RouteArgument(
                                              id: '0',
                                              param: widget.order.productOrders[0].product.market.id,
                                              // heroTag: widget.order..heroTag,
                                            ));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "اسم الأسرة  :   ",
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                          Icon(Icons.turn_left,color: Theme.of(context).accentColor,),
                                          Flexible(
                                            child: Text(
                                              widget.order.productOrders[0].product.market.name,
                                              maxLines: 4,


                                              style:TextStyle(decoration: TextDecoration.underline,color: Theme.of(context).accentColor),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ],

                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                        Icon(
                            widget.order.active
                                ?widget.order.orderStatus.status=="طلب جديد" ? Icons.fiber_new_outlined:
                            widget.order.orderStatus.status=="جاري التجهيز"? Icons.access_time_outlined:
                            widget.order.orderStatus.status=="الطلب جاهز"?Icons.incomplete_circle:
                            widget.order.orderStatus.status=="في الطريق"?Icons.delivery_dining_outlined:
                            Icons.done
                                : Icons.disabled_by_default_outlined,color: Theme.of(context).accentColor,
                          size: 35,

                            )
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Helper.getPrice(Helper.getTotalOrdersPrice(widget.order), context, style: Theme.of(context).textTheme.headline4),
                        // Text(
                        //   '${widget.order.payment.method}',
                        //   style: Theme.of(context).textTheme.caption,
                        // )
                      ],
                    ),
                    children: <Widget>[
                      Column(
                          children: List.generate(
                            widget.order.productOrders.length,
                                (indexProduct) {
                              return ProductOrderItemWidget(heroTag: 'mywidget.orders',
                                  order: widget.order,
                                  // lastIndex: indexProduct==widget.order.productOrders.length-1 ?false:true,
                                  productOrder: widget.order.productOrders.elementAt(indexProduct));
                            },
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Column(
                          children: <Widget>[

                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "تكلفة التوصيل",
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                Helper.getPrice(widget.order.deliveryFee, context,
                                    style: Theme.of(context).textTheme.subtitle1)
                              ],
                            ),
                            Divider(color: theme.accentColor.withOpacity(.4)),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    '${S.of(context).tax}       (${widget.order.tax}%)',
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                Helper.getPrice(
                                    Helper.getTaxOrder(widget.order), context,
                                    style: Theme.of(context).textTheme.subtitle1)
                              ],
                            ),
                            Divider(color: theme.accentColor.withOpacity(.4)),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    S.of(context).total,
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                Helper.getPrice(
                                    Helper.getTotalOrdersPrice(widget.order),
                                    context,
                                    style: Theme.of(context).textTheme.headline6)
                              ],
                            ),
                            Divider(color: theme.accentColor.withOpacity(.4)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).pushNamed('/Tracking',
                                                  arguments:
                                                      RouteArgument(id: widget.order.id));
                                  },
                                  child: Container(
                                   padding:EdgeInsets.only(bottom: 10,top: 10,left:
                                   40,right: 40),
                                    decoration: BoxDecoration(color: Theme.of(context).accentColor,

                                    borderRadius: BorderRadius.circular(30)


                                    ),
                                    child: Text("متابعة",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w700),),
                                  ),
                                ),
                                if ( widget.order.orderStatus.status=="تم التوصيل")
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).pushNamed('/Reviews', arguments: RouteArgument(id: widget.order.id, heroTag: "market_reviews"));

                                    },
                                    child: Container(
                                      padding:EdgeInsets.only(bottom: 10,top: 10,left:
                                      40,right: 40),
                                      decoration: BoxDecoration(color: Theme.of(context).accentColor,

                                          borderRadius: BorderRadius.circular(30)

                                      ),
                                      child: Center(child: Text("تقييم الطلب",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w700),)),
                                    ),
                                  ),


                                if (widget.order.canCancelOrder()&&widget.order.orderStatus.status!="تم التوصيل")
                                  GestureDetector(
                                    onTap: (){
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(30)),
                                            title: Wrap(
                                              spacing: 10,
                                              children: <Widget>[
                                                Text(
                                                  'حذف الطلب',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .hintColor),
                                                ),
                                              ],
                                            ),
                                            content: Text(S
                                                .of(context)
                                                .areYouSureYouWantToCancelThisOrder),
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 25),
                                            actions: <Widget>[
                                              MaterialButton(
                                                elevation: 0,
                                                child: new Text(
                                                  'حذف',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .hintColor),
                                                ),
                                                onPressed: () {
                                                  widget.onCanceled(widget.order);
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              MaterialButton(
                                                elevation: 0,
                                                child: new Text(
                                                  "الرجوع",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .hintColor),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding:EdgeInsets.only(bottom: 10,top: 10,left:
                                      40,right: 40),
                                      decoration: BoxDecoration(color: Colors.transparent
                                          ,

                                          borderRadius: BorderRadius.circular(30)


                                      ),
                                      child: Text('حذف الطلب',style: TextStyle(color: Theme.of(context).accentColor,fontWeight: FontWeight.w700),),
                                    ),
                                  ),

                              ],
                            )

                            //   ],
                            // ),
                          ],
                        ),
                      ),


                    ],
                  ),

                ),
              ),
            ),

          ],
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                // margin: EdgeInsetsDirectional.only(start: 0),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 28,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: widget.order.active
                        ?widget.order.orderStatus.status=="طلب جديد" ?Colors.cyan:
                    widget.order.orderStatus.status=="جاري التجهيز"?Colors.amber:
                    widget.order.orderStatus.status=="الطلب جاهز"?Colors.lightGreen:
                    widget.order.orderStatus.status=="في الطريق"?Colors.deepOrangeAccent:
                    Theme.of(context).accentColor
                        : Colors.grey),
                alignment: AlignmentDirectional.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('رقم الطلب :   ',
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                    Text(
                      widget.order.id,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 28,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: widget.order.active
                        ?widget.order.orderStatus.status=="طلب جديد" ?Colors.cyan:
                    widget.order.orderStatus.status=="جاري التجهيز"?Colors.amber:
                    widget.order.orderStatus.status=="الطلب جاهز"?Colors.lightGreen:
                    widget.order.orderStatus.status=="في الطريق"?Colors.deepOrangeAccent:
                    Theme.of(context).accentColor
                        : Colors.grey),
                alignment: AlignmentDirectional.center,
                child: Text(
                  widget.order.active
                      ? '${widget.order.orderStatus.status}'
                      : 'تم الإلغاء',
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: TextStyle(
                       color: Theme.of(context).primaryColor)


                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
