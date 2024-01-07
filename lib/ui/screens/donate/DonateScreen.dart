import 'package:flutter/material.dart';
import 'package:patta/app/app_constants.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/style.dart';
import 'package:patta/app/url_launcher.dart';

class DonateScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(children: <Widget>[ buildPreamble(context, I18n.get("donate_preamble")) ]),
          Row(mainAxisSize: MainAxisSize.min,
              children: <Widget>[ buildGradientButton(AppConstants.DONATE_URL, I18n.get("donate")) ]
          ),
          Row(children: <Widget>[ buildPreamble(context, I18n.get("donate_time_preamble")) ]),
          Row(mainAxisSize: MainAxisSize.min,
              children: <Widget>[ buildGradientButton(AppConstants.DONATE_TIME_URL, I18n.get("donate_time")) ]
          ),
          Row(children: <Widget>[ SizedBox(height: 40) ]),
        ],
      )
    );
  }

  Expanded buildPreamble(BuildContext context, text) {
    return Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(text,
                        style: serifFont(context: context)),
                  ),
                ),
              );
  }

  buildGradientButton(url, text) {
    return Padding(padding: const EdgeInsets.all(6.0),
      child:
      ClipRRect(borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: AppThemes.contextFreeButtonGradient
                  ),
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: tryLaunchUrl(url),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }

}
