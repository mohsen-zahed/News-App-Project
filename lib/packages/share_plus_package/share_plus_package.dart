import 'package:share_plus/share_plus.dart';

class MySharePlusPackage {
  static MySharePlusPackage? _instance;
  MySharePlusPackage._();
  static MySharePlusPackage get instance {
    _instance ??= MySharePlusPackage._();
    return _instance!;
  }

  Future<ShareResult> shareApp<T>(String text, String title) async {
    return await Share.share(title, subject: text);
  }
}
