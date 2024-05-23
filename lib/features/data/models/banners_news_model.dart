import 'package:news_app_project/config/constants/images_paths.dart';

class BannersNewsModel {
  String title;
  String description;
  String content;
  String newsLink;
  String imageUrl;
  String publishedDate;
  String sourceName;
  String sourceUrl;

  BannersNewsModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        description = json['description'] ?? '',
        content = json['content'] ?? '',
        newsLink = json['url'] ?? '',
        imageUrl = json['urlToImage'] ?? imageDownloadFailed,
        publishedDate = json['publishedAt'] ?? '',
        sourceName = json['source']['name'] ?? '',
        sourceUrl = json['source']['url'] ?? '';
}
