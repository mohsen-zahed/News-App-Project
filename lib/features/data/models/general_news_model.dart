import 'package:news_app_project/helpers/helper_functions.dart';

class GeneralNewsModel {
  String source;
  String author;
  String title;
  String description;
  String url;
  String imageUrl;
  String publishedAt;
  String content;
  GeneralNewsModel.fromJson(Map<String, dynamic> json)
      : source = json['source']['name'] ?? '',
        author = json['author'] ?? '',
        title = json['title'] ?? '',
        description = json['description'] ?? 'No content available for this post!',
        url = json['url'] ?? '',
        imageUrl = helperFunctions.getFileType(json['image']),
        publishedAt = json['publishedAt'] ?? '',
        content = json['content'] ?? '';
}
