import 'package:flutter/material.dart';
import 'package:patta/app/app_themes.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/style.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      child: Text(I18n.get("donatePreamble"),
                          style: serifFont(context: context)),
                    ),
                  ),
                ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
                        onPressed: tryLaunchDonateUrl,
                        child: Text(I18n.get("donate")),
                      ),
                    ],
                  ),
              ),
            ]
          ),
        ],
      );
  }

  Future<void> tryLaunchDonateUrl() async {
    var url = Uri.parse("https://pariyatti.org/Donate-Now");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw "{$I18n.get('couldNotLaunch')} $url";
    }
  }
}
