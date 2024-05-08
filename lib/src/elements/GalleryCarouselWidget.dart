import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../elements/GalleryItemWidget.dart';
import '../models/gallery.dart';

class ImageThumbCarouselWidget extends StatefulWidget {
  final List<Gallery> galleriesList;

  ImageThumbCarouselWidget({Key key, this.galleriesList}) : super(key: key);

  @override
  _ImageThumbCarouselWidgetState createState() => _ImageThumbCarouselWidgetState();
}

class _ImageThumbCarouselWidgetState extends State<ImageThumbCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.galleriesList.isEmpty
        ? SizedBox(height: 5)
        : Container(
            height: 250,

            child:
            CarouselSlider.builder(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
                height: 250,
                viewportFraction: .7,
              ),
              itemCount: widget.galleriesList.length,
              itemBuilder: (context, index, realIndex) {

    return  GalleryItemWidget(gallery: widget.galleriesList.elementAt(index));
              },

            )

          );
  }
}
