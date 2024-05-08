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

class HelpWidget extends StatefulWidget {
  @override
  _HelpWidgetState createState() => _HelpWidgetState();
}

class _HelpWidgetState extends StateMVC<HelpWidget> {
  FaqController _con;

  _HelpWidgetState() : super(FaqController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return _con.faqs.isEmpty
        ? CircularLoadingWidget(height: 500)
        : DefaultTabController(
            length: _con.faqs.length,
            child: Scaffold(
              key: _con.scaffoldKey,
              appBar: AppBar(
                backgroundColor: Theme.of(context).accentColor,
                elevation: 0,
                centerTitle: true,
                leading: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    }
                    ,child: Icon(Icons.arrow_back_ios,color:Theme.of(context).primaryColor ,)),

                // iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                bottom: TabBar(
                  tabs: List.generate(_con.faqs.length, (index) {
                    return Tab(text: _con.faqs.elementAt(index).name ?? '');
                  }),
                  labelColor: Theme.of(context).primaryColor,
                ),
                title: Text(
                  'الأسئلة الشائعة',
                  style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3, color: Theme.of(context).primaryColor)),
                ),
                // actions: <Widget>[
                //   new ShoppingCartButtonWidget(iconColor: Theme.of(context).primaryColor, labelColor: Theme.of(context).accentColor),
                // ],
              ),
              body: Stack(
                children: [
                  backgroundImage(),
                  RefreshIndicator(
                    color: Theme.of(context).accentColor,
                    onRefresh: _con.refreshFaqs,
                    child: TabBarView(
                      children: List.generate(_con.faqs.length, (index) {
                        return SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[

                              ListView.separated(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                primary: false,
                                itemCount: _con.faqs.elementAt(index).faqs.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 15);
                                },
                                itemBuilder: (context, indexFaq) {
                                  return FaqItemWidget(faq: _con.faqs.elementAt(index).faqs.elementAt(indexFaq));
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
