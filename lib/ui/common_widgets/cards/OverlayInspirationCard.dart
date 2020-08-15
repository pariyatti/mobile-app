import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patta/local_database/database.dart';
import 'package:patta/resources/strings.dart';
import 'package:patta/ui/common_widgets/bookmark_button.dart';
import 'package:patta/ui/model/OverlayInspirationCardModel.dart';
import 'package:patta/util.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class OverlayInspirationCard extends StatelessWidget {
  final OverlayInspirationCardModel data;
  final PariyattiDatabase database;

  OverlayInspirationCard(this.data, this.database, {Key key}) : super(key: key);

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
              Stack(
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
                          Icons.error,
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
              Container(
                color: Color(0xffdcd3c0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    BookmarkButton(data, database),
                    Expanded(
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.share,
                          color: Color(0xff6d695f),
                        ),
                        onPressed: () async {
                          final String extension =
                              extractFileExtension(data.imageUrl);
                          var response = await http.get(data.imageUrl);
                          await WcFlutterShare.share(
                            sharePopupTitle:
                                strings['en'].labelShareInspiration,
                            mimeType: 'image/$extension',
                            fileName: '${data.header}.$extension',
                            bytesOfFile: response.bodyBytes,
                            text: data.text,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
