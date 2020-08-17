import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/resources/strings.dart';
import 'package:patta/ui/common_widgets/bookmark_button.dart';
import 'package:patta/ui/common_widgets/pariyatti_icons.dart';
import 'package:patta/ui/common_widgets/share_button.dart';
import 'package:patta/ui/model/OverlayInspirationCardModel.dart';
import 'package:patta/util.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class OverlayInspirationCard extends StatelessWidget {
  final OverlayInspirationCardModel data;
  final PariyattiDatabase database;
  final GlobalKey _renderKey = new GlobalKey();

  OverlayInspirationCard(this.data, this.database, {Key key}) : super(key: key);

  Future<Uint8List> _getImageWithText() async {
    try {
      RenderRepaintBoundary boundary =
          _renderKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final listOfButtons = List<Widget>();

    if (data.isBookmarkable) {
      listOfButtons.add(BookmarkButton(data, database));
    }

    listOfButtons.add(ShareButton(
      () async {
        Uint8List imageData = await _getImageWithText();
        final String extension = extractFileExtension(data.imageUrl);
        await WcFlutterShare.share(
          sharePopupTitle: strings['en'].labelShareInspiration,
          mimeType: 'image/$extension',
          fileName: '${data.header}.$extension',
          bytesOfFile: imageData,
        );
      },
    ));

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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 12.0,
                ),
                child: Text(
                  data.header.toUpperCase(),
                  style: TextStyle(
                    inherit: true,
                    fontSize: 14.0,
                    color: Color(0xff999999),
                  ),
                ),
              ),
              RepaintBoundary(
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
                      errorWidget: (context, url, error) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Icon(
                            PariyattiIcons.get(IconName.error),
                            color: Color(0xff6d695f),
                          ),
                        ),
                      ),
                      imageUrl: data.imageUrl,
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data.text,
                            style: TextStyle(
                                inherit: true,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Serif',
                                color: Color(int.parse(
                                    data.textColor.replaceFirst('#', '0xFF')))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xffdcd3c0),
                child: Row(
                    mainAxisSize: MainAxisSize.max, children: listOfButtons),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
