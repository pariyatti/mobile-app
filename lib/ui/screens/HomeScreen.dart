import 'package:flutter/material.dart';
import 'package:patta/resources/strings.dart';
import 'package:patta/ui/common_widgets/pariyatti_icons.dart';
import 'package:patta/ui/screens/account/AccountScreen.dart';
import 'package:patta/ui/screens/today/TodayScreen.dart';

enum HomeScreenTab { TODAY, ACCOUNT }

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
        titleText = '${strings['en'].appName} - ${strings['en'].labelToday}';
        bodyWidget = TodayScreen();
        break;
      case HomeScreenTab.ACCOUNT:
        bottomNavigationBarIndex = 1;
        titleText = '${strings['en'].appName} - ${strings['en'].labelAccount}';
        bodyWidget = AccountScreen();
        break;
    }

    return Scaffold(
      backgroundColor: Color(0xfff4efe7),
      appBar: AppBar(
        title: Text(
          titleText,
          style: TextStyle(
            inherit: true,
            color: Color(0xff6d695f),
          ),
        ),
      ),
      body: bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavigationBarIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              PariyattiIcons.today(),
              color: Color(0xff6d695f),
            ),
            activeIcon: Icon(
              PariyattiIcons.today(),
              color: Color.fromARGB(255, 186, 86, 38),
            ),
            title: Text(
              strings['en'].labelToday,
              style: TextStyle(
                inherit: true,
                color: bottomNavigationBarIndex == 0
                    ? Color.fromARGB(255, 186, 86, 38)
                    : Color(0xff6d695f),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              PariyattiIcons.person(),
              color: Color(0xff6d695f),
            ),
            activeIcon: Icon(
              PariyattiIcons.person(),
              color: Color.fromARGB(255, 186, 86, 38),
            ),
            title: Text(
              strings['en'].labelAccount,
              style: TextStyle(
                inherit: true,
                color: bottomNavigationBarIndex == 1
                    ? Color.fromARGB(255, 186, 86, 38)
                    : Color(0xff6d695f),
              ),
            ),
          )
        ],
        onTap: (int tappedItemIndex) {
          this.setState(() {
            if (tappedItemIndex == 0) {
              this._tab = HomeScreenTab.TODAY;
            } else if (tappedItemIndex == 1) {
              this._tab = HomeScreenTab.ACCOUNT;
            }
          });
        },
      ),
    );
  }
}
