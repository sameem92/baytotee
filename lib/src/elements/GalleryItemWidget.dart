import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../elements/CircularLoadingWidget.dart';
import '../models/gallery.dart';

class GalleryItemWidget extends StatelessWidget {
  final Gallery gallery;

  GalleryItemWidget({Key key, this.gallery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return gallery == null
        ? CircularLoadingWidget(height: 200)
        : Container(
            width: 320,


            margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: gallery.image.url,
                placeholder: (context, url) => Image.asset(
                  'assets/img/loading.gif',
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
              ),
            ),
          );
  }
}
