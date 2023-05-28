import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/ui/common/bookmark_button.dart';
import 'package:patta/ui/common/card_header.dart';
import 'package:patta/ui/common/pariyatti_icons.dart';
import 'package:patta/ui/common/share_button.dart';
import 'package:patta/model/OverlayInspirationCardModel.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/ui/common/shared_image.dart';
import 'package:share_plus/share_plus.dart';


class OverlayInspirationCard extends StatefulWidget {
  final OverlayInspirationCardModel data;
  final PariyattiDatabase database;

  OverlayInspirationCard(this.data, this.database, {Key? key}) : super(key: key);

  @override
  _OverlayInspirationCardState createState() => _OverlayInspirationCardState();
}

class _OverlayInspirationCardState extends State<OverlayInspirationCard> {
  final GlobalKey _renderKey = new GlobalKey();
  bool loaded = false;

  @override
  void initState() {
    // Check if image is in cache in case widget gets rebuilt and the onLoaded callback doesn't respond.
    // ignore: unnecessary_null_comparison
    loaded = DefaultCacheManager().getFileFromMemory(widget.data.imageUrl!) != null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CardHeader(context, widget.data.header ?? I18n.get("inspiration")),
              buildOverlayWords(),
              buildButtonFooter(),
            ],
          ),
        ),
      ),
    );
  }

  RepaintBoundary buildOverlayWords() {
    return RepaintBoundary(
              key: _renderKey,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    placeholder: (context, url) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    //Custom callback added to the package to know when the image is loaded.
                    //Does not give a value if widget is rebuilt. See initState for workaround.
                    // onLoad: (value) {
                    //   setState(() {
                    //     loaded = value;
                    //   });
                    // },
                    errorWidget: (context, url, error) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Icon(
                          PariyattiIcons.get(IconName.error),
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                    imageUrl: widget.data.imageUrl!,
                    imageBuilder: (context, imageProvider) {
                      return Image(
                        image: imageProvider,
                        fit: BoxFit.fitWidth,
                      );
                    },
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Visibility(
                        visible: loaded,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.data.text ?? "<inspiration text ${I18n.get("was_empty")}>",
                            style: TextStyle(
                                inherit: true,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Serif',
                                color: AppThemes.overlayText(widget.data.textColor)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
  }

  Container buildButtonFooter() {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        buildBookmarkButton(),
        buildShareButton(),
      ]),
    );
  }

  Visibility buildBookmarkButton() {
    return Visibility(
        child: BookmarkButton(widget.data, widget.database),
        visible: widget.data.isBookmarkable,
      );
  }

  ShareButton buildShareButton() {
    return ShareButton(onPressed: loaded == true ? () async {
      Uint8List bytes = await SharedImage.getBytesFromRenderKey(_renderKey);
      SharedImage img = SharedImage(bytes, widget.data.header!, widget.data.imageUrl);
      await Share.shareXFiles(
          [await img.toXFile()],
          subject: I18n.get("share_inspiration"));
    } : null);
  }

}
