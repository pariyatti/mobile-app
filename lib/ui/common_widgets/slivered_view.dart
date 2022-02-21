import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliveredView extends StatelessWidget {
  final String title;
  final Widget body;
  const SliveredView({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child:

      NestedScrollView(
        headerSliverBuilder: (_, __) {
          return [
            SliverAppBar(
              backgroundColor: Color(0xfff4efe7), // 0xfff4efe7 // 0xff8899efe7
              expandedHeight: 58,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                centerTitle: false,
                titlePadding:
                EdgeInsets.fromLTRB(16, 0, 0, 0), // EdgeInsetsDirectional.only(start: 24, bottom: 0)
                collapseMode: CollapseMode.none,
              ),
            ),
          ];
        },
        body: SafeArea(child: body),
      ),

    );
  }
}
