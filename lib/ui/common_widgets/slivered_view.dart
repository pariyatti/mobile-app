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
        overscroll.disallowGlow();
        return false;
      },
      child: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return [
            SliverAppBar(
              backgroundColor: Color(0xfff4efe7), // 0xfff4efe7 // 0xff8899efe7
              expandedHeight: 60,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(title),
                titlePadding: EdgeInsets.all(24),
              ),
            ),
          ];
        },
        body: SafeArea(child: body),
      ),
    );
  }
}
