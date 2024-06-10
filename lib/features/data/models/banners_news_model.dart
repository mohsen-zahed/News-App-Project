import 'package:hive/hive.dart';
import 'package:news_app/config/constants/images_paths.dart';
part 'banners_news_model.g.dart';

@HiveType(typeId: 0)
class BannersNewsModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String author;
  @HiveField(2)
  String description;
  @HiveField(3)
  String content;
  @HiveField(4)
  String imageUrl;
  @HiveField(5)
  String publishedAt;
  @HiveField(6)
  String source;
  @HiveField(7)
  String url;

  BannersNewsModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
  });

  BannersNewsModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        author = json['author'] ?? 'Unknown',
        description = json['description'] ?? '',
        content = json['content'] ?? 'No content available for this post!',
        url = json['url'] ?? '',
        imageUrl = json['urlToImage'] ?? imageDownloadFailed,
        publishedAt = json['publishedAt'] ?? '',
        source = json['source']['name'] ?? '';

  @override
  bool operator ==(Object other) => identical(this, other) || other is BannersNewsModel && runtimeType == other.runtimeType && title == other.title;

  @override
  int get hashCode => title.hashCode;
}
