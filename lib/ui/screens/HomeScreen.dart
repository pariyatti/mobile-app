import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/ui/common/pariyatti_icons.dart';
import 'package:patta/ui/common/slivered_view.dart';
import 'package:patta/ui/screens/account/AccountScreen.dart';
import 'package:patta/ui/screens/donate/DonateScreen.dart';
import 'package:patta/ui/screens/library/LibraryScreen.dart';
import 'package:patta/ui/screens/today/TodayScreen.dart';


// TODO: remove duplication
enum HomeScreenTab { TODAY, LIBRARY, DONATE, ACCOUNT }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenTab _tab = HomeScreenTab.TODAY;

  void rebuild() {
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    int bottomNavigationBarIndex;
    String titleText;
    Widget bodyWidget;
    switch (_tab) {
      case HomeScreenTab.TODAY:
        // TODO: remove duplication
        bottomNavigationBarIndex = 0;
        titleText = '${I18n.get("today")}';
        bodyWidget = SliveredView(
          title: titleText,
          body: TodayScreen(),
        );
        break;
      case HomeScreenTab.LIBRARY:
        // TODO: remove duplication
        bottomNavigationBarIndex = 1;
        titleText = '${I18n.get("library")} ';
        bodyWidget = SliveredView(
            title: titleText,
            body: LibraryScreen()
        );
        break;
      case HomeScreenTab.DONATE:
        // TODO: remove duplication
        bottomNavigationBarIndex = 2;
        titleText = '${I18n.get("donate")}';
        bodyWidget = SliveredView(
          title: titleText,
          body: DonateScreen(),
        );
        break;
      case HomeScreenTab.ACCOUNT:
        // TODO: remove duplication
        bottomNavigationBarIndex = 3;
        titleText = '${I18n.get("account")}';
        bodyWidget = SliveredView(
          title: titleText,
          body: AccountScreen(rebuild),
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
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          // TODO: remove duplication
          BottomNavigationBarItem(
            icon: Icon(
              PariyattiIcons.get(IconName.today),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            activeIcon: Icon(
              PariyattiIcons.get(IconName.today),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            label: I18n.get("today")
          ),
          BottomNavigationBarItem(
              icon: Icon(
                PariyattiIcons.get(IconName.book),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              activeIcon: Icon(
                PariyattiIcons.get(IconName.book),
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              label: I18n.get("library")
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
              label: I18n.get("donate")
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
              label: I18n.get("account")
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
