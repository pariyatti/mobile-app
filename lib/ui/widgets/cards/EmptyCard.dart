import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/ui/common/bookmark_button.dart';
import 'package:patta/ui/common/card_header.dart';
import 'package:patta/ui/common/share_button.dart';
import 'package:patta/model/CardModel.dart';

class EmptyCard extends StatefulWidget {
  final CardModel data;
  final PariyattiDatabase database;

  EmptyCard(this.data, this.database, {Key? key}) : super(key: key);

  @override
  _EmptyCardState createState() => _EmptyCardState();
}

class _EmptyCardState extends State<EmptyCard> {
  final GlobalKey _renderKey = new GlobalKey();
  bool loaded = false;

  // Future<Uint8List> _getImageWithText() async {
  //   try {
  //     RenderRepaintBoundary boundary =
  //     _renderKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  //     ByteData byteData =
  //     await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
  //     var pngBytes = byteData.buffer.asUint8List();
  //     return pngBytes;
  //   } catch (e) {
  //     print(e);
  //     throw e;
  //   }
  //   // was: return null;
  // }

  @override
  void initState() {
    //Check if image is in cache in case widget gets rebuilt and the onLoaded callback doesn't respond.
    loaded = true;
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
              CardHeader(context, I18n.get("empty_card")),
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
                            Icons.error,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                      imageUrl: "<${I18n.get("empty_card")}>",
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
                              "<empty card ${I18n.get("was_empty")}>",
                              style: TextStyle(
                                  inherit: true,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Serif',
                                  color: Theme.of(context).colorScheme.surface),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.secondary,
                child: Row(mainAxisSize: MainAxisSize.max, children: [
                  Visibility(
                    child: BookmarkButton(widget.data, widget.database),
                    visible: widget.data.isBookmarkable,
                  ),
                  ShareButton(
                    onPressed:
                    loaded ? () async {} : null,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
