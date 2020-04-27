import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patta/common_widgets/bookmark_button.dart';
import 'package:patta/data_model/inspiration_card.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/resources/strings.dart';
import 'package:patta/util.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class InspirationCard extends StatelessWidget {
  final InspirationCardModel data;
  final PariyattiDatabase database;

  InspirationCard(this.data, this.database, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        strings['en']
                            .titleCardInspirationOfTheDay
                            .toUpperCase(),
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
                      imageUrl: data.imageUrl,
                      imageBuilder: (context, imageProvider) {
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
                        data.text,
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
                                  sharePopupTitle: strings['en'].labelShareInspiration,
                                  mimeType: 'image/$extension',
                                  fileName: '${strings['en'].titleCardInspirationOfTheDay}.$extension',
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
          ),
        ),
      ],
    );
  }
}
