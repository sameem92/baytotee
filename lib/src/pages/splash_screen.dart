import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/splash_screen_controller.dart';
import '../helpers/app_config.dart' as config;
// import '../helpers/app_config.dart';
import '../helpers/helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends StateMVC<SplashScreen> {
  SplashScreenController _con;

  SplashScreenState() : super(SplashScreenController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    _con.progress.addListener(() {
      double progress = 0;
      _con.progress.value.values.forEach((_progress) {
        progress += _progress;
      });
      if (progress == 100) {
        try {
          Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1);
        } catch (e) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Stack(
        children: [
          backgroundImage(),
          Positioned(
            left: config.App(context).appWidth(50) -135,
            bottom: config.App(context).appHeight(50) - 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // SizedBox(height: config.App(context).appHeight(50),),
                Container(
                  padding: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.white,

                      // border: Border.all(color: Colors.red,
                      // ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 50,
                          color: Theme.of(context).hintColor.withOpacity(0.7),
                        )
                      ]),
                  child: Image.asset(
                    'assets/img/logo-splash.png',
                    width: 250,
                    height: 250,
                    // fit: BoxFit.cover,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    // scale: .01,
                  ),
                ),
                SizedBox(height: config.App(context).appHeight(5),),
                Text(
                  "منتجات صنعناها بحب",
                  style: Theme.of(context).textTheme.headline2.merge(TextStyle(color:  Color(0xFF4d9f7e)
                      ,
                      wordSpacing:2,
                      fontWeight: FontWeight.w600,
                      shadows:[
                        Shadow(blurRadius: 10,
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                        )
                      ] ,)),
                )
              ],
            ),

            // ),
          ),
          // Positioned(
          //   left: config.App(context).appWidth(20),
          //   bottom: config.App(context).appHeight(10) -  config.App(context).appHeight(18.5),
          //   child: Container(
          //     width: 350,
          //     height: config.App(context).appHeight(37),
          //     child:
          //     Text(
          //       "منتجات صنعناها بحب",
          //       style: Theme.of(context).textTheme.headline2.merge(TextStyle(color:  Color(0xFF4d9f7e)
          //       ,
          //       wordSpacing:2,
          //       fontFamily:'fonts/ProductSans',
          //       fontStyle: FontStyle.italic,
          //       letterSpacing: 2,
          //       fontWeight: FontWeight.w600,
          //       shadows:[
          //         Shadow(blurRadius: 10,
          //         color: Theme.of(context).hintColor.withOpacity(0.2),
          //       )
          //       ] )),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

