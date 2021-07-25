import 'package:flutter/material.dart';
import 'package:patta/resources/strings.dart';
import 'package:patta/ui/screens/account/tabs/BookmarksTab.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TabBar(
                  isScrollable: true,
                  tabs: <Widget>[
                    Tab(text: AppStrings.get().labelBookmarks),
                  ],
                  indicatorColor: Color(0xff6d695f),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                BookmarksTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
