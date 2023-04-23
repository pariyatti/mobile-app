import 'package:flutter/material.dart';
import 'package:patta/app/app_constants.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/style.dart';
import 'package:patta/app/url_launcher.dart';

class DonateScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(I18n.get("donate_preamble"),
                          style: serifFont(context: context)),
                    ),
                  ),
                ),
            ],
          ),
          Row(mainAxisSize: MainAxisSize.min,
              children: <Widget>[ buildGradientButton(donateUrl, I18n.get("donate")) ]
          ),
          Row(mainAxisSize: MainAxisSize.min,
              children: <Widget>[ buildGradientButton(donateTimeUrl, I18n.get("donate_time")) ]
          ),
        ],
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
