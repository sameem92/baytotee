import 'dart:async';

import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../helpers/app_config.dart' as config;
import 'CircularLoadingWidget.dart';

class EmptyNotificationsWidget extends StatefulWidget {
  EmptyNotificationsWidget({
    Key key,
  }) : super(key: key);

  @override
  _EmptyNotificationsWidgetState createState() => _EmptyNotificationsWidgetState();
}

class _EmptyNotificationsWidgetState extends State<EmptyNotificationsWidget> {
  bool loading = true;

  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          loading

       ?CircularLoadingWidget(height: 800):

          Container(
            alignment: AlignmentDirectional.center,
            padding: EdgeInsets.symmetric(horizontal: 30),
            height: config.App(context).appHeight(100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Opacity(
                  opacity: 0.4,
                  child: Text(
                    "لا يوجد إشعارات",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3.merge(TextStyle(fontWeight: FontWeight.w300)),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
