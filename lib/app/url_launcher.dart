import 'package:url_launcher/url_launcher.dart';
import 'I18n.dart';

tryLaunchUrl(uri) {
  var url = Uri.parse(uri);
  return () async => {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw "{$I18n.get('could_not_launch')} $url"
    }
  };
}
