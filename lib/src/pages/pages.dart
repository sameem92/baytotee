import 'package:Baytotee/src/pages/settings.dart';
import 'package:flutter/material.dart';

import '../elements/DrawerWidget.dart';
import '../elements/FilterWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../pages/home.dart';
import '../pages/map.dart';
import '../pages/notifications.dart';
import '../pages/orders.dart';
import '../repository/user_repository.dart';
import 'messages.dart';

// ignore: must_be_immutable
class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  RouteArgument routeArgument;
  Widget currentPage = HomeWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesWidget({
    Key key,
    this.currentTab=1,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 1;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage =currentUser.value.apiToken == null?Navigator.of(context).pushNamed('/Login'): SettingsWidget();
          break;
           case 1:
          widget.currentPage = HomeWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 2:
          widget.currentPage =currentUser.value.apiToken == null?Navigator.of(context).pushNamed('/Login'): widget.currentPage = OrdersWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
           }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: widget.scaffoldKey,

        body: widget.currentPage,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,

          selectedItemColor: Theme.of(context).accentColor,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 22,

          elevation: 0,
          backgroundColor: Colors.transparent,
          unselectedIconTheme: IconThemeData(size: 25),
          selectedIconTheme: IconThemeData(size: 28),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: widget.currentTab,
          onTap: (int i) {
            this._selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(widget.currentTab == 0 ? Icons.person_pin_rounded : Icons.person_pin_outlined),
                  Text('حسابي',style: TextStyle(color: widget.currentTab == 0 ?Theme.of(context).accentColor:Colors.black),)
                ],
              ),
              label: '',

            ),

            BottomNavigationBarItem(
                label: '',
                icon: Container(

                    width: 42,
                      height: 42
                ,child: ColoredBox(color:widget.currentTab == 1 ?Theme.of(context).accentColor.withOpacity(0.4): Colors.transparent

                    ,child: Image.asset('assets/img/handmade.png')))),

                // Container(
                //   width: 42,
                //   height: 42,
                //   margin: EdgeInsets.only(bottom: 5),
                //   decoration: BoxDecoration(
                //     // color: Theme.of(context).accentColor,
                //     borderRadius: BorderRadius.all(
                //       Radius.circular(50),
                //     ),
                //     boxShadow: [
                //       BoxShadow(color: Theme.of(context).accentColor.withOpacity(0.4), blurRadius: 40, offset: Offset(0, 15)),
                //       BoxShadow(color: Theme.of(context).accentColor.withOpacity(0.4), blurRadius: 13, offset: Offset(0, 3))
                //     ],
                //   ),
                //   child: Image.asset('assets/img/handmade.png')
                //   // Icon(widget.currentTab == 1 ? Icons.made : Icons.home_outlined,
                //   //     color: Theme.of(context).primaryColor),
                // )),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  new Icon(widget.currentTab == 2 ? Icons.fact_check_rounded : Icons.fact_check_outlined),
                  Text('طلباتي',style: TextStyle(color: widget.currentTab == 2 ?Theme.of(context).accentColor:Colors.black),)

                ],
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
