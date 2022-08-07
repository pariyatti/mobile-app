import 'package:flutter/material.dart';
import 'package:patta/resources/strings.dart';
import 'package:patta/ui/screens/account/tabs/BookmarksTab.dart';
import 'package:patta/ui/screens/account/tabs/SettingsTab.dart';

class AccountScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
                    Tab(text: AppStrings.get().labelSettings)
                  ],
                  labelColor: Theme.of(context).colorScheme.onSecondary,
                  indicatorColor: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                BookmarksTab(),
                SettingsTab()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
