import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/faq_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/DrawerWidget.dart';
import '../elements/FaqItemWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../helpers/helper.dart';

class PrivacyWidget extends StatefulWidget {
  @override
  _PrivacyWidgetState createState() => _PrivacyWidgetState();
}

class _PrivacyWidgetState extends StateMVC<PrivacyWidget> {
  // FaqController _con;

  // _PrivacyWidgetState() : super(FaqController()) {
  //   _con = controller;
  // }

  @override
  Widget build(BuildContext context) {
    return
      // _con.faqs.isEmpty
      //   ? CircularLoadingWidget(height: 500)
      //   : DefaultTabController(
      // length: _con.faqs.length,
      // child:
    Scaffold(
        // key: _con.scaffoldKey,
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              }
              ,child: Icon(Icons.arrow_back_ios,color:Theme.of(context).accentColor ,)),

          // iconTheme: IconThemeData(color: Theme.of(context).primaryColor),

          title: Text(
            'سياسة الخصوصية',
            style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1, color: Theme.of(context).accentColor)),
          ),
          // actions: <Widget>[
          //   new ShoppingCartButtonWidget(iconColor: Theme.of(context).primaryColor, labelColor: Theme.of(context).accentColor),
          // ],
        ),
        body: Stack(
          children: [
            backgroundImage(),
            Column(
              children: [
                SizedBox(height: 150,),
                Center(child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('asas ajs ojas oasoasoasoiaso aso asi aos oas oas oas oas oa soas oas oasoiasoasoaas'),
                )),
              ],
            ),
          ],
        ),
      // ),
    );
  }
}
