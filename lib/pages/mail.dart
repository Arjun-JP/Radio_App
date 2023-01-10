import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future openlink({required Uri url}) => _lounchurl(url);
}

Future _lounchurl(Uri url) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  }
}
