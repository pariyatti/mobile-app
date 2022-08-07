import 'package:flutter/material.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/model/DateCardModel.dart';
import 'package:patta/app/style.dart';

class DateCard extends StatefulWidget {
  final DateCardModel data;
  final PariyattiDatabase database;

  DateCard(this.data, this.database, {Key? key}) : super(key: key);

  @override
  _DateCardState createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  late bool loaded;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 14.0 // 12 + 2
            ),
            child: Text(
              widget.data.humanDate.toUpperCase() ?? "<date was empty>",
              style: sanSerifFont(context: context, fontSize: 14.0, color: Theme.of(context).colorScheme.onBackground)
            ),
          )
        )
      ],
    );
  }

}
