import 'package:patta/app/I18n.dart';
import 'package:patta/model/Language.dart';

import 'Feed.dart';

class FeedList {
  var pali;
  var buddha;
  var dohas;
  var inspiration;

  FeedList(Language selectedLanguage) {
    I18n.set(selectedLanguage);
    pali = Feed("pali", I18n.get("paliWordOfTheDay"));
    buddha = Feed("buddha", I18n.get("wordsOfTheBuddha"));
    dohas = Feed("dohas", I18n.get("dhammaVerse"));
    inspiration = Feed("inspiration", I18n.get("inspiration"));
  }

  all() {
    return <Feed>[pali, buddha, dohas, inspiration];
  }
}
