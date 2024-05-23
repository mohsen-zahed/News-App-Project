import 'package:hive/hive.dart';
import 'package:news_app_project/config/constants/images_paths.dart';
part 'banners_news_model.g.dart';

@HiveType(typeId: 0)
class BannersNewsModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  String content;
  @HiveField(3)
  String newsLink;
  @HiveField(4)
  String imageUrl;
  @HiveField(5)
  String publishedDate;
  @HiveField(6)
  String sourceName;
  @HiveField(7)
  String sourceUrl;

  BannersNewsModel({
    required this.content,
    required this.description,
    required this.imageUrl,
    required this.newsLink,
    required this.publishedDate,
    required this.sourceName,
    required this.sourceUrl,
    required this.title,
  });

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
