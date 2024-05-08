import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/market_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/DrawerWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../models/conversation.dart';
import '../models/market.dart';
import '../models/route_argument.dart';
import '../repository/user_repository.dart';
import 'chat.dart';
import 'map.dart';
import 'market.dart';
import 'menu_list.dart';

// ignore: must_be_immutable
class DetailsWidget extends StatefulWidget {
  RouteArgument routeArgument;
  dynamic currentTab=0;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget currentPage;

  DetailsWidget({
    Key key,
    this.currentTab,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 0;
    }
  }

  @override
  _DetailsWidgetState createState() {
    return _DetailsWidgetState();
  }
}

class _DetailsWidgetState extends StateMVC<DetailsWidget> {
  MarketController _con;

  _DetailsWidgetState() : super(MarketController()) {
    _con = controller;
  }

  initState() {
    _selectTab(widget.currentTab=0);
    super.initState();
  }

  @override
  void didUpdateWidget(DetailsWidget oldWidget) {
    _selectTab(oldWidget.currentTab=0);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          _con.listenForMarket(id: widget.routeArgument.param).then((value) {
            setState(() {
              _con.market = value as Market;
              print(_con.market.toMap());
              widget.currentPage = MarketWidget(parentScaffoldKey: widget.scaffoldKey, routeArgument: RouteArgument(param: _con.market));
            });
          });
          break;
        // case 1:
        //   if (currentUser.value.apiToken == null) {
        //     widget.currentPage = PermissionDeniedWidget();
        //   } else {
        //     Conversation _conversation = new Conversation(
        //         _con.market?.users?.map((e) {
        //           e.image = _con.market.image;
        //           return e;
        //         })?.toList(),
        //         name: _con.market.name);
        //     widget.currentPage = ChatWidget(parentScaffoldKey: widget.scaffoldKey, routeArgument: RouteArgument(id: _con.market.id, param: _conversation));
        //   }
        //   break;
   ;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: widget.scaffoldKey,

        body: widget.currentPage ?? CircularLoadingWidget(height: 800));
  }
}
