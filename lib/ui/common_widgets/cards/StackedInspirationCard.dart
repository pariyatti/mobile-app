import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patta/local_database/database.dart';
import 'package:patta/resources/strings.dart';
import 'package:patta/ui/common_widgets/bookmark_button.dart';
import 'package:patta/ui/common_widgets/share_button.dart';
import 'package:patta/ui/model/StackedInspirationCardModel.dart';
import 'package:patta/util.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class StackedInspirationCard extends StatefulWidget {
  final StackedInspirationCardModel data;
  final PariyattiDatabase database;

  StackedInspirationCard(this.data, this.database, {Key key}) : super(key: key);

  @override
  _StackedInspirationCardState createState() => _StackedInspirationCardState();
}

class _StackedInspirationCardState extends State<StackedInspirationCard> {
  @override
  Widget build(BuildContext context) {
    final listOfButtons = List<Widget>();
    bool loading = true;

    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
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
                        widget.data.header.toUpperCase(),
                        style: TextStyle(
                          inherit: true,
                          fontSize: 14.0,
                          color: Color(0xff999999),
                        ),
                      ),
                    ),
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
                            Icons.error,
                            color: Color(0xff6d695f),
                          ),
                        ),
                      ),
                      imageUrl: widget.data.imageUrl,
                      imageBuilder: (context, imageProvider) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          setState(() {
                            loading = false;
                          });
                        });
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Image(
                                image: imageProvider,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.data.text,
                        style: TextStyle(
                          inherit: true,
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xffdcd3c0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Visibility(
                            visible: widget.data.isBookmarkable,
                            child: BookmarkButton(widget.data, widget.database),
                          ),
                          IgnorePointer(
                            ignoring: loading,
                            child: ShareButton(
                              onPressed: () async {
                                final String extension =
                                    extractFileExtension(widget.data.imageUrl);
                                var response =
                                    await http.get(widget.data.imageUrl);
                                await WcFlutterShare.share(
                                  sharePopupTitle:
                                      strings['en'].labelShareInspiration,
                                  mimeType: 'image/$extension',
                                  fileName: '${widget.data.header}.$extension',
                                  bytesOfFile: response.bodyBytes,
                                  text: widget.data.text,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
