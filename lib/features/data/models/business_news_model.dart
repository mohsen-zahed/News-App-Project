import 'package:hive/hive.dart';
import 'package:news_app/config/constants/images_paths.dart';
part 'business_news_model.g.dart';

@HiveType(typeId: 1)
class BusinessNewsModel {
  @HiveField(0)
  String source;
  @HiveField(1)
  String author;
  @HiveField(2)
  String title;
  @HiveField(3)
  String description;
  @HiveField(4)
  String url;
  @HiveField(5)
  String imageUrl;
  @HiveField(6)
  String publishedAt;
  @HiveField(7)
  String content;

  BusinessNewsModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
  });

  BusinessNewsModel.fromJson(Map<String, dynamic> json)
      : source = json['source']['name'] ?? '',
        author = json['author'] ?? '',
        title = json['title'] ?? '',
        description = json['description'] ?? 'No content available for this post!',
        url = json['url'] ?? '',
        imageUrl = json['urlToImage'] ?? imageDownloadFailed,
        publishedAt = json['publishedAt'] ?? '',
        content = json['content'] ?? '';
  @override
  bool operator ==(Object other) => identical(this, other) || other is BusinessNewsModel && runtimeType == other.runtimeType && title == other.title;

  @override
  int get hashCode => title.hashCode;
}
