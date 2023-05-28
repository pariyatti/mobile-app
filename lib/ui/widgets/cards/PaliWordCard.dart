import 'package:flutter/material.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/ui/common/bookmark_button.dart';
import 'package:patta/ui/common/card_header.dart';
import 'package:patta/ui/common/share_button.dart';
import 'package:patta/model/PaliWordCardModel.dart';
import 'package:patta/app/style.dart';
import 'package:share_plus/share_plus.dart';

class PaliWordCard extends StatelessWidget {
  final PaliWordCardModel data;
  final PariyattiDatabase database;

  PaliWordCard(this.data, this.database, {Key? key}) : super(key: key);

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
              color: Theme.of(context).colorScheme.surface,
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
                    CardHeader(context, I18n.get("pali_word")),
                    buildPaliWord(context),
                    buildButtonFooter(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildPaliWord(context) {
    return RepaintBoundary(
      child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child:
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 0.0,
                    ),
                    child: Text(
                        data.pali ?? "<pali text ${I18n.get("was_empty")}>",
                        style: serifFont(context: context, fontSize: 18.0, color: Theme.of(context).colorScheme.onSurface)
                    ),
                  )
                ),
                Container(height: 12.0),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                        I18n.get("translation"),
                        style: sanSerifFont(context: context, fontSize: 14.0, color: Theme.of(context).colorScheme.onBackground)
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                    child: Text(
                        data.translation ?? "<translation ${I18n.get("was_empty")}>",
                        style: serifFont(context: context, fontSize: 18.0, color: Theme.of(context).colorScheme.onSurface)
                    ),
                  )
                )
              ],
            )
        ]
      )
    );
  }

  Container buildButtonFooter(context) {
    var listOfButtons = <Widget>[];
    if (data.isBookmarkable) {
      listOfButtons.add(BookmarkButton(data, database));
    }

    listOfButtons.add(ShareButton(
      onPressed: () async {
        await Share.share(
          '${data.header}: \n${data.pali}\n\n${I18n.get("translation")}: \n${data.translation}',
          subject: I18n.get("share_pali_word")
        );
      },
    ));

    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: listOfButtons,
      ),
    );
  }
}
