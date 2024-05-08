import 'package:Baytotee/src/elements/CircularLoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/notification_controller.dart';
import '../elements/EmptyNotificationsWidget.dart';
import '../elements/NotificationItemWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../helpers/helper.dart';
import '../repository/user_repository.dart';

class NotificationsWidget extends StatefulWidget {
  // final GlobalKey<ScaffoldState> parentScaffoldKey;

  // NotificationsWidget({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends StateMVC<NotificationsWidget> {
  NotificationController _con;

  _NotificationsWidgetState() : super(NotificationController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _con.scaffoldKey,
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
          S.of(context).notifications,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1)),
        ),

      ),
      body:
      Stack(
            children: [
              backgroundImage(),
              RefreshIndicator(
                  onRefresh: _con.refreshNotifications,
                color: Theme.of(context).accentColor,
                  child: _con.notifications.isEmpty
                      ? CircularLoadingWidget(height: 800)
                      : ListView(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          children: <Widget>[
                            SizedBox(height: 100,),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 20, right: 10),
                            //   child: ListTile(
                            //     contentPadding: EdgeInsets.symmetric(vertical: 0),
                            //
                            //     subtitle: Text(
                            //      'اسحب لليمين للحذف',
                            //       maxLines: 2,
                            //       overflow: TextOverflow.ellipsis,
                            //       style: Theme.of(context).textTheme.caption,
                            //     ),
                            //   ),
                            // ),
                            ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: _con.notifications.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 15);
                              },
                              itemBuilder: (context, index) {
                                return NotificationItemWidget(
                                  notification: _con.notifications.elementAt(index),
                                  onMarkAsRead: () {
                                    _con.doMarkAsReadNotifications(_con.notifications.elementAt(index));
                                  },
                                  onMarkAsUnRead: () {
                                    _con.doMarkAsUnReadNotifications(_con.notifications.elementAt(index));
                                  },
                                  onRemoved: () {
                                    _con.doRemoveNotification(_con.notifications.elementAt(index));
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                ),
            ],
          ),
    );
  }
}
