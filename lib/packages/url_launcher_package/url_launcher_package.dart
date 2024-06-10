import 'package:url_launcher/url_launcher.dart';

class MyUrlLauncherPackage {
  static MyUrlLauncherPackage? _instance;
  MyUrlLauncherPackage._();
  static MyUrlLauncherPackage get instance {
    _instance ??= MyUrlLauncherPackage._();
    return _instance!;
  }

  Future<dynamic> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchURL(url);
    } else {
      return 'Could not launch $url';
    }
  }
}
