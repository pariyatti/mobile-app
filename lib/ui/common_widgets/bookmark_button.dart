import 'package:flutter/material.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/local_database/moor_converters.dart' as moor_converters;
import 'package:patta/ui/common_widgets/pariyatti_icons.dart';
import 'package:patta/ui/model/CardModel.dart';

class BookmarkButton extends StatelessWidget {
  final CardModel data;
  final PariyattiDatabase database;

  const BookmarkButton(this.data, this.database, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<bool>(
        stream: database.isCardBookmarked(data.id),
        builder: (context, snapshot) {
          final isBookmarked = (snapshot.hasData && snapshot.data);

          Icon icon;
          if (isBookmarked) {
            icon = Icon(
              PariyattiIcons.bookmarkFilled(),
              color: Color(0xff6d695f),
            );
          } else {
            icon = Icon(
              PariyattiIcons.bookmark(),
              color: Color(0xff6d695f),
            );
          }
          return MaterialButton(
            padding: EdgeInsets.zero,
            child: icon,
            onPressed: () async {
              if (isBookmarked) {
                database.removeCard(data.id);
              } else {
                database.insertCard(moor_converters.toDatabaseCard(
                  data,
                  DateTime.now(),
                ));
              }
            },
          );
        },
      ),
    );
  }
}
