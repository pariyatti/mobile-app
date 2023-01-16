import 'package:flutter/material.dart';
import 'package:patta/app/strings.dart';
import 'package:patta/ui/common/pariyatti_icons.dart';
import 'package:patta/ui/common/slivered_view.dart';
import 'package:patta/ui/screens/account/AccountScreen.dart';
import 'package:patta/ui/screens/donate/DonateScreen.dart';
import 'package:patta/ui/screens/today/TodayScreen.dart';

enum HomeScreenTab { TODAY, ACCOUNT, DONATE }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenTab _tab = HomeScreenTab.TODAY;

  @override
  Widget build(BuildContext context) {
    int bottomNavigationBarIndex;
    String titleText;
    Widget bodyWidget;
    switch (_tab) {
      case HomeScreenTab.TODAY:
        bottomNavigationBarIndex = 0;
        titleText = '${AppStrings.get().labelToday}';
        bodyWidget = SliveredView(
          title: titleText,
          body: TodayScreen(),
        );
        break;
      case HomeScreenTab.ACCOUNT:
        bottomNavigationBarIndex = 1;
        titleText = '${AppStrings.get().labelAccount}';
        bodyWidget = SliveredView(
          title: titleText,
          body: AccountScreen(),
        );
        break;
      case HomeScreenTab.DONATE:
        bottomNavigationBarIndex = 2;
        titleText = '${AppStrings.get().labelDonate}';
        bodyWidget = SliveredView(
          title: titleText,
          body: DonateScreen(),
        );
        break;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavigationBarIndex,
        backgroundColor: Theme.of(context).colorScheme.background,
        fixedColor: Theme.of(context).colorScheme.inversePrimary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              PariyattiIcons.get(IconName.today),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            activeIcon: Icon(
              PariyattiIcons.get(IconName.today),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            label: AppStrings.get().labelToday
          ),
          BottomNavigationBarItem(
            icon: Icon(
              PariyattiIcons.get(IconName.person),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            activeIcon: Icon(
              PariyattiIcons.get(IconName.person),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            label: AppStrings.get().labelAccount
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.volunteer_activism,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              activeIcon: Icon(
                Icons.volunteer_activism,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              label: AppStrings.get().labelDonate
          ),
        ],
        onTap: (int tappedItemIndex) {
          this.setState(() {
            this._tab = HomeScreenTab.values[tappedItemIndex];
          });
        },
      ),
    );
  }
}
