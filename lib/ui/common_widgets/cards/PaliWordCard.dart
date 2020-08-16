import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/resources/strings.dart';
import 'package:patta/ui/common_widgets/bookmark_button.dart';
import 'package:patta/ui/common_widgets/pariyatti_icons.dart';
import 'package:patta/ui/common_widgets/share_button.dart';
import 'package:patta/ui/model/PaliWordCardModel.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class PaliWordCard extends StatelessWidget {
  final PaliWordCardModel data;
  final PariyattiDatabase database;

  PaliWordCard(this.data, this.database, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listOfButtons = List<Widget>();

    if (data.isBookmarkable) {
      listOfButtons.add(BookmarkButton(data, database));
    }

    listOfButtons.add(ShareButton(
      () async {
        await WcFlutterShare.share(
          sharePopupTitle: strings['en'].labelSharePaliWord,
          mimeType: 'text/plain',
          text:
              '${data.header}: ${data.pali}\n${strings['en'].labelTranslation}: ${data.translation}',
        );
      },
    ));

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
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
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
                            color: Color(0xff999999)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 0.0,
                      ),
                      child: Text(
                        data.pali,
                        style: TextStyle(
                          inherit: true,
                          fontSize: 18.0,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Container(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        strings['en'].labelTranslation,
                        style: TextStyle(
                          inherit: true,
                          fontSize: 14.0,
                          color: Color(0xff999999),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                      child: Text(
                        data.translation,
                        style: TextStyle(
                          inherit: true,
                          fontSize: 18.0,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xffdcd3c0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: listOfButtons,
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
