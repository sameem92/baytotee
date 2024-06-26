import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../repository/user_repository.dart' as userRepo;

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends StateMVC<LoginWidget> {
  UserController _con;

  _LoginWidgetState() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    if (userRepo.currentUser.value?.apiToken != null) {
      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(

        extendBodyBehindAppBar: true,
        key: _con.scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: (){
                // Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1);
              }
              ,child: Icon(Icons.arrow_back_ios,color:Theme.of(context).accentColor ,)),

          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          elevation: 0,


        ),
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            backgroundImage(),
            Positioned(
              top: 0,
              child: Container(
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(50),
                decoration: BoxDecoration(color: Theme.of(context).accentColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 50,
                        color: Theme.of(context).hintColor.withOpacity(0.9),
                      )
                    ]),
                child: Image.asset('assets/img/logo.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                ),
                padding: EdgeInsets.zero,

              ),
            ),
            Positioned(
              top: config.App(context).appHeight(50)-70,
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)), boxShadow: [
                  BoxShadow(
                    blurRadius: 50,
                    color: Theme.of(context).hintColor.withOpacity(0.5),
                  )
                ]),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: EdgeInsets.only(top: 50, right: 27, left: 27, bottom: 20),
                width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
                child: Form(
                  key: _con.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Theme.of(context).accentColor,
                        onSaved: (input) => _con.user.email = input,
                        validator: (input) => !input.contains('@') ||!input.contains('.') ? S.of(context).should_be_a_valid_email : null,
                        decoration: InputDecoration(
                          labelText: S.of(context).email,

                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'your email@gmail.com',
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.5)),
                          prefixIcon: Icon(Icons.email_outlined, color: Theme.of(context).accentColor),

                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.4)),
                                borderRadius: BorderRadius.circular(15)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(15)),

                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(15)),

                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(15)),

                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.text,

                        onSaved: (input) => _con.user.password = input,
                        cursorColor: Theme.of(context).accentColor,
                        validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                        obscureText: _con.hidePassword,
                        decoration: InputDecoration(
                          labelText: S.of(context).password,
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: '••••••••••••',
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.5)),
                          prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _con.hidePassword = !_con.hidePassword;
                              });
                            },
                            color: Theme.of(context).focusColor,
                            icon: Icon(_con.hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1)),
                          borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(15)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(15)),

                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(15)),

                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(15)),

                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(15)),


                        ),
                      ),
                      SizedBox(height: 30),
                      BlockButtonWidget(
                        text: Text(
                          S.of(context).login,
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          _con.login();
                        },
                      ),
                      SizedBox(height: 15),
                      MaterialButton(
                        elevation: 0,
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1);
                        },
                        shape: StadiumBorder(),
                        textColor: Theme.of(context).focusColor,
                        child: Text(S.of(context).skip),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                      ),
//                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    elevation: 0,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/ForgetPassword');
                    },
                    textColor: Theme.of(context).hintColor,
                    child: Text(S.of(context).i_forgot_password),
                  ),
                  MaterialButton(
                    elevation: 0,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/SignUp');
                    },
                    textColor: Theme.of(context).hintColor,
                    child: Text(S.of(context).i_dont_have_an_account),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
