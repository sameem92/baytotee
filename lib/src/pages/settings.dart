import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/media.dart';
import '../repository/settings_repository.dart';
import '../repository/upload_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/settings_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/MobileVerificationBottomSheetWidget.dart';
import '../elements/PaymentSettingsDialog.dart';
import '../elements/ProfileSettingsDialog.dart';
import '../elements/SearchBarWidget.dart';
import '../helpers/helper.dart';
import '../repository/user_repository.dart';
import 'package:image_picker/image_picker.dart';
import '../repository/user_repository.dart' as userRepo;

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key key}) : super(key: key);
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends StateMVC<SettingsWidget> {
  SettingsController _con;
  PickedFile image;
  String uuid;
  UploadRepository _uploadRepository;
  OverlayEntry loader;
  _SettingsWidgetState() : super(SettingsController()) {
    _con = controller;
    _uploadRepository = new UploadRepository();
  }

  Future pickImage(
      ImageSource source, ValueChanged<String> uploadCompleted) async {
    ImagePicker imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(
      source: source,
      imageQuality: 80,
    );
    if (pickedImage != null) {
      try {
        setState(() {
          image = pickedImage;
        });
        loader = Helper.overlayLoader(context);
        FocusScope.of(context).unfocus();
        Overlay.of(context).insert(loader);
        uuid = await _uploadRepository.uploadImage(File(image.path), 'avatar');
        uploadCompleted(uuid);
        userRepo.currentUser.value.image = new Media(id: uuid);
        _con.update(userRepo.currentUser.value);
        Helper.hideLoader(loader);
      } catch (e) {}
    } else {}
  }

  @override
  void initState() {
    _con.listenForUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        body: currentUser.value.id == null
            ? CircularLoadingWidget(height: 500)
            : SafeArea(
                top: false,
                bottom: false,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: Stack(
                    children: [
                      backgroundImage(),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 70,
                          ),
                          Text(
                            'حسابي',
                            style: Theme.of(context).textTheme.headline6,
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.3),
                                    offset: Offset(0, 3),
                                    blurRadius: 20)
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.person_outline,
                                        size: 22,
                                        color: Theme.of(context).focusColor,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'الملف الشخصي',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ],
                                  ),
                                  trailing: ButtonTheme(
                                    padding: EdgeInsets.all(0),
                                    minWidth: 50.0,
                                    height: 25.0,
                                    child: ProfileSettingsDialog(
                                      user: currentUser.value,
                                      onChanged: () {
                                        // var bottomSheetController = _con
                                        //     .scaffoldKey.currentState
                                        //     .showBottomSheet(
                                        //   (context) =>
                                        //       MobileVerificationBottomSheetWidget(
                                        //           scaffoldKey: _con.scaffoldKey,
                                        //           user: currentUser.value),
                                        //   shape: RoundedRectangleBorder(
                                        //     borderRadius: new BorderRadius.only(
                                        //         topLeft: Radius.circular(10),
                                        //         topRight: Radius.circular(10)),
                                        //   ),
                                        // );
                                        // bottomSheetController.closed
                                        //     .then((value) {
                                          _con.update(currentUser.value);
                                        // });
                                        //setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                                ListTile(
                                  onTap: () {},
                                  dense: true,
                                  title: Text(
                                    S.of(context).full_name,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  trailing: Text(
                                    currentUser.value.name,
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor),
                                  ),
                                ),
                                ListTile(
                                  onTap: () {},
                                  dense: true,
                                  title: Text(
                                    S.of(context).email,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  trailing: Text(
                                    currentUser.value.email,
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor),
                                  ),
                                ),
                                ListTile(
                                  onTap: () {},
                                  dense: true,
                                  title: Wrap(
                                    spacing: 8,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        S.of(context).phone,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                      if (currentUser.value.verifiedPhone ??
                                          false)
                                        Icon(
                                          Icons.check_circle_outline,
                                          color: Theme.of(context).accentColor,
                                          size: 22,
                                        )
                                    ],
                                  ),
                                  trailing: Text(
                                    currentUser.value.phone,
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor),
                                  ),
                                ),
                                // ListTile(
                                //   onTap: () {},
                                //   dense: true,
                                //   title: Text(
                                //     S.of(context).address,
                                //     style:
                                //         Theme.of(context).textTheme.bodyText2,
                                //   ),
                                //   trailing: Text(
                                //     Helper.limitString(
                                //         currentUser.value.address ??
                                //             "---"),
                                //     overflow: TextOverflow.fade,
                                //     softWrap: false,
                                //     style: TextStyle(
                                //         color: Theme.of(context).focusColor),
                                //   ),
                                // ),
                                // ListTile(
                                //   onTap: () {},
                                //   dense: true,
                                //   title: Text(
                                //     S.of(context).about,
                                //     style:
                                //         Theme.of(context).textTheme.bodyText2,
                                //   ),
                                //   trailing: Text(
                                //     Helper.limitString(currentUser.value.bio),
                                //     overflow: TextOverflow.fade,
                                //     softWrap: false,
                                //     style: TextStyle(
                                //         color: Theme.of(context).focusColor),
                                //   ),
                                // ),
                                // Image.network(currentUser.value.image.thumb),
                                // Image.network(userRepo.currentUser.value.image.thumb),
                                // Image.network(Media(id: uuid).thumb),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: InkWell(
                                          borderRadius: BorderRadius.circular(300),
                                          child: Stack(children: [
                                            SizedBox(
                                              width: 150,
                                              height: 150,
                                              child: CachedNetworkImage(
                                                height: 150,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                imageUrl: currentUser.value.image.thumb,

                                                placeholder: (context, url) => Image.asset(
                                                  'assets/img/loading.gif',
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: 150,
                                                ),
                                                errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Theme.of(context).accentColor,),
                                              ),
                                              // CircleAvatar(
                                              //   backgroundColor: Theme.of(context).accentColor,
                                              //   backgroundImage: NetworkImage(
                                              //       currentUser.value.image.thumb),
                                              // ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Icon(
                                                  FontAwesomeIcons.upload,
                                                  color: Theme.of(context).accentColor.withOpacity(.7),
                                                  size: 25,
                                                )),
                                            // currentUser.value.image.thumb.isEmpty ||currentUser.value.image.thumb==null ||
                                            // currentUser.value.image.thumb==''
                                            //
                                            //     ?
                                            // Center(child: Icon(Icons.person,size: 100,color: Colors.white,)):Column()
                                          ]),
                                          onTap: () async {
                                            await pickImage(ImageSource.gallery,
                                                    (uuid) {
                                                  userRepo.currentUser.value.image =
                                                  new Media(id: uuid);
                                                });
                                          })),
                                ),
                                // ListTile(
                                //
                                //   title: Row(
                                //     children: <Widget>[
                                //       Icon(
                                //         Icons.credit_card,
                                //         size: 22,
                                //         color: Theme.of(context).focusColor,
                                //       ),
                                //       SizedBox(width: 10),
                                //       Text(
                                //         "حفظ بطاقتك",
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .bodyText2,
                                //       ),
                                //     ],
                                //   ), dense: true,
                                //   trailing: ButtonTheme(
                                //     padding: EdgeInsets.all(0),
                                //     minWidth: 50.0,
                                //     height: 25.0,
                                //     child: PaymentSettingsDialog(
                                //       creditCard: _con.creditCard,
                                //       onChanged: () {
                                //         _con.updateCreditCard(_con.creditCard);
                                //         //setState(() {});
                                //       },
                                //     ),
                                //   ),
                                // ),
                                // ListTile(
                                //   onTap: () {
                                //     Navigator.of(context)
                                //         .pushNamed('/DeliveryAddresses');
                                //   },
                                //   dense: true,
                                //   title: Row(
                                //     children: <Widget>[
                                //       Icon(
                                //         Icons.place_outlined,
                                //         size: 22,
                                //         color: Theme.of(context).focusColor,
                                //       ),
                                //       SizedBox(width: 10),
                                //       Text(
                                //         S.of(context).delivery_addresses,
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .bodyText2,
                                //       ),
                                //     ],
                                //   ),
                                //   trailing: ButtonTheme(
                                //     padding: EdgeInsets.all(0),
                                //     minWidth: 50.0,
                                //     height: 25.0,
                                //     child: GestureDetector(
                                //       onTap: () {
                                //         Navigator.of(context)
                                //             .pushNamed('/DeliveryAddresses');
                                //       },
                                //       child: Icon(Icons.arrow_forward_ios),
                                //     ),
                                //   ),
                                // ),
                                ListTile(
                                  onTap: () {
                                    Navigator.of(context).pushNamed('/Help');
                                  },
                                  dense: true,
                                  title: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.help_outline,
                                        size: 22,
                                        color: Theme.of(context).focusColor,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'الأسئلة الشائعة',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ],
                                  ),
                                  trailing:Icon(Icons.arrow_forward_ios)
                                ),



                                ListTile(
                                  onTap: () {
                                    Navigator.of(context).pushNamed('/privacy');
                                  },
                                  dense: true,
                                  title: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.privacy_tip_outlined,
                                        size: 22,
                                        color: Theme.of(context).focusColor,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'سياسة الخصوصية',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ],
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios)
                                ),




                                ListTile(
                                  onTap: () {
                                    final String url = 'https://www.google.com/';
                                    // // Platform.isIOS?"https://apps.apple.com/il/app/nourah-%D9%86%D9%88%D8%B1%D9%87/id1604129474" :
                                    // // "https://play.google.com/store/apps/details?id=com.nourah.producer_family_app";
                                    // // final RenderBox box =context.findRenderObject();
                                    Share.share(
                                      url,
                                    );
                                  },
                                  dense: true,
                                  title: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.share,
                                        size: 22,
                                        color: Theme.of(context).focusColor,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'شارك التطبيق',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ],
                                  ),
                                  trailing:Icon(Icons.arrow_forward_ios)
                                ),
                                ListTile(
                                  onTap: () {
                                    const _url = 'https://googlePlay.com';
                                    launchURL(_url);
                                  },
                                  dense: true,
                                  title: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.star_rate_outlined,
                                        size: 22,
                                        color: Theme.of(context).focusColor,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "تقييم بيتوتي",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ],
                                  ),
                                  trailing:Icon(Icons.arrow_forward_ios)
                                ),


                                ListTile(
                                  enabled: false,
                                  // onTap: () {
                                  //   // Navigator.pushNamed(context, '/termsScreen');
                                  // },
                                  title:Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                                        child: GestureDetector(onTap: (){
                                          print('1111');
                                          // launchURL(_url);
                                        },child: Icon(  FontAwesomeIcons.instagram,color:Theme.of(context).accentColor,size: 30,)),
                                      ),  Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                                        child: GestureDetector(onTap: (){ print('22222');
                                          // launchURL(_url);
                                        },child: Icon(  FontAwesomeIcons.twitter,color:Theme.of(context).accentColor,size: 30,)),
                                      ),  Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                                        child: GestureDetector(onTap: (){
                                          print('333333');
                                          // launchURL(_url);
                                        },child: Icon(  FontAwesomeIcons.tiktok,color:Theme.of(context).accentColor,size: 30,)),
                                      ),

                                    ],
                                  ),

                                ),

                                ListTile(
                                  onTap: () {
                                    openEmail(context: context);
                                  },
                                  dense: true,
                                  title: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.email_outlined,
                                        size: 22,
                                        color: Theme.of(context).focusColor,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'تواصل معنا',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ],
                                  ),
                                  trailing:Icon(Icons.arrow_forward_ios)
                                ),
                                ListTile(
                                  onTap: () {
                                    if (currentUser.value.apiToken != null) {
                                      logout().then((value) {
                                        Navigator.of(context).pushNamedAndRemoveUntil('/Pages', (Route<dynamic> route) =>
                                        false, arguments: 1);
                                      });
                                    }
                                  },
                                  dense: true,

                                  title:Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.exit_to_app_outlined,
                                        size: 22,
                                        color: Theme.of(context).focusColor,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        currentUser.value.apiToken != null ? S.of(context).log_out : '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ],
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios)
                                ),




                                setting.value.enableVersion?  ListTile(
                                  dense: true,
                                  title: Center(
                                    child: Text(
                                      S.of(context).version + " " + setting.value.appVersion,
                                      style: Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),


                                ):SizedBox()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
  }

  static Future openEmail({ BuildContext context}) async {
    String toEmail = 'baytotee@gmail.com';
    String subject = Localizations.localeOf(context).languageCode == 'ar'
        ? 'استفسار بخصوص ...'
        : 'Inquiry about ...';
    String body = Localizations.localeOf(context).languageCode == 'ar'
        ? 'اسمي:(           )      ، مرحبا أود الاستفسار منكم عن ...'
        : 'My name is:(               )      ، Hello  ...';

    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print("No email client found");
    }
  }
}

void launchURL(url) async => await canLaunchUrl(Uri.parse(url))
    ? await launchUrl(Uri.parse(url))
    : throw 'Could not launch $url';



