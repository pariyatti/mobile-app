import 'package:flutter/material.dart';
import 'package:patta/app/preferences.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/model/Language.dart';
import 'package:patta/ui/common/bookmark_button.dart';
import 'package:patta/ui/common/card_header.dart';
import 'package:patta/ui/common/share_button.dart';
import 'package:patta/model/PaliWordCardModel.dart';
import 'package:patta/app/style.dart';
import 'package:share_plus/share_plus.dart';

class PaliWordCard extends StatefulWidget {
  final PaliWordCardModel data;
  final PariyattiDatabase database;

  PaliWordCard(this.data, this.database, {Key? key}) : super(key: key);

  @override
  _PaliWordCardState createState() => _PaliWordCardState();
}

class _PaliWordCardState extends State<PaliWordCard> {
  Language _selectedLanguage = Language.eng;

  @override
  void initState() {
    initLanguage();
    super.initState();
  }

  void initLanguage() async {
    setState(() {
      _selectedLanguage = Preferences.getLanguage(Language.SETTINGS_KEY);
    });
  }

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
                    CardHeader(context, I18n.get("pali_word"), Theme.of(context).colorScheme.surface),
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
      child: Container(decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        child:
        Stack(
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
                    child: getPaliText(),
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
                    child: getTranslationText(),
                  )
                )
              ],
            )
          ]
        ),
      ),
    );
  }

  Text getTranslationText() => Text(getTranslation(), style: serifFont(context: context));
  String getTranslation() => widget.data.translations![_selectedLanguage.code] ?? "<translation ${I18n.get("was_empty")}>";

  Text getPaliText() => Text(getPali(), style: serifFont(context: context));
  String getPali() => widget.data.pali ?? "<words field ${I18n.get("was_empty")}>";

  Container buildButtonFooter(context) {
    var listOfButtons = <Widget>[];
    if (widget.data.isBookmarkable) {
      listOfButtons.add(BookmarkButton(widget.data, widget.database));
    }

    listOfButtons.add(ShareButton(
      onPressed: () async {
        await Share.share(
          '${widget.data.header}: \n${widget.data.pali}\n\n${I18n.get("translation")}: \n${widget.data.translation}',
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
