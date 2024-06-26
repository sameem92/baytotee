
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../models/slide.dart';
import 'CircularLoadingWidget.dart';
import 'HomeSliderLoaderWidget.dart';

class HomeSliderWidget extends StatefulWidget {
  final List<Slide> slides;

  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();

  HomeSliderWidget({Key key, this.slides}) : super(key: key);
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int _current = 0;
  AlignmentDirectional _alignmentDirectional;

  @override
  Widget build(BuildContext context) {
    return widget.slides == null || widget.slides.isEmpty
        ? Column()
        : Stack(
            alignment: _alignmentDirectional ?? Helper.getAlignmentDirectional(widget.slides.elementAt(0).textPosition),
            fit: StackFit.passthrough,
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  height: 250,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                      _alignmentDirectional = Helper.getAlignmentDirectional(widget.slides.elementAt(index).textPosition);
                    });
                  },
                ),
                items: widget.slides.map((Slide slide) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        height: 230,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.090), blurRadius: 20, offset: Offset(0, 2)),
                          ],
                        ),
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: (){
                                if (slide.market.id != 'null') {
                                  Navigator.of(context).pushNamed('/Details', arguments: RouteArgument(id: '0', param: slide.market.id, heroTag: 'home_slide'));
                                } else if (slide.product.id != 'null') {
                                  Navigator.of(context).pushNamed('/Product', arguments: RouteArgument(id: slide.product.id, heroTag: 'home_slide'));
                                }

                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                child: CachedNetworkImage(
                                  height: 200,
                                  width: double.infinity,
                                  fit: Helper.getBoxFit(slide.imageFit),
                                  imageUrl: slide.image.url,
                                  placeholder: (context, url) => Image.asset(
                                    'assets/img/loading.gif',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error_outline),
                                ),
                              ),
                            ),
                            // Container(
                            //   alignment: Helper.getAlignmentDirectional(slide.textPosition),
                            //   width: double.infinity,
                            //   padding: const EdgeInsets.symmetric(horizontal: 20),
                            //   child: Container(
                            //     width: config.App(context).appWidth(40),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.stretch,
                            //       mainAxisSize: MainAxisSize.max,
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: <Widget>[
                            //         if (slide.text != null && slide.text != '')
                            //           Text(
                            //             slide.text,
                            //             style: Theme.of(context).textTheme.headline6.merge(
                            //                   TextStyle(
                            //                     fontSize: 14,
                            //                     height: 1,
                            //                     color: Helper.of(context).getColorFromHex(slide.textColor),
                            //                   ),
                            //                 ),
                            //             textAlign: TextAlign.center,
                            //             overflow: TextOverflow.fade,
                            //             maxLines: 3,
                            //           ),
                            //         if (slide.button != null && slide.button != '')
                            //           MaterialButton(
                            //             elevation: 0,
                            //             onPressed: () {
                            //               if (slide.market.id != 'null') {
                            //                 Navigator.of(context).pushNamed('/Details', arguments: RouteArgument(id: '0', param: slide.market.id, heroTag: 'home_slide'));
                            //               } else if (slide.product.id != 'null') {
                            //                 Navigator.of(context).pushNamed('/Product', arguments: RouteArgument(id: slide.product.id, heroTag: 'home_slide'));
                            //               }
                            //             },
                            //             padding: EdgeInsets.symmetric(vertical: 5),
                            //             color: Helper.of(context).getColorFromHex(slide.buttonColor),
                            //             shape: StadiumBorder(),
                            //             child: Text(
                            //               slide.button,
                            //               textAlign: TextAlign.start,
                            //               style: TextStyle(color: Theme.of(context).primaryColor),
                            //             ),
                            //           ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Positioned(
                bottom: 40,
                // left: ,
                child: Container(
                  // margin: EdgeInsets.symmetric(vertical: 22, horizontal: 42),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.slides.map((Slide slide) {
                      return Container(
                        width: 10.0,
                        height: 3.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: _current == widget.slides.indexOf(slide)
                                ? Helper.of(context).getColorFromHex(slide.textColor)
                                : Helper.of(context).getColorFromHex(slide.textColor).withOpacity(0.3)),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
  }
}
