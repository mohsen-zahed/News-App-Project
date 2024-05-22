import 'package:news_app_project/config/constants/images_paths.dart';

class BusinessNewsModel {
  String source;
  String author;
  String title;
  String description;
  String url;
  String imageUrl;
  String publishedAt;
  String content;
  BusinessNewsModel.fromJson(Map<String, dynamic> json)
      : source = json['source']['name'] ?? '',
        author = json['author'] ?? '',
        title = json['title'] ?? '',
        description = json['description'] ?? 'No content available for this post!',
        url = json['url'] ?? '',
        imageUrl = json['urlToImage'] ?? imageDownloadFailed,
        publishedAt = json['publishedAt'] ?? '',
        content = json['content'] ?? '';
}
