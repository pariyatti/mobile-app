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
    pali = Feed("pali", I18n.get("pali_word_of_the_day"));
    buddha = Feed("buddha", I18n.get("words_of_the_buddha"));
    dohas = Feed("dohas", I18n.get("dhamma_verse"));
    inspiration = Feed("inspiration", I18n.get("inspiration"));
  }

  all() {
    return <Feed>[pali, buddha, dohas, inspiration];
  }
}
