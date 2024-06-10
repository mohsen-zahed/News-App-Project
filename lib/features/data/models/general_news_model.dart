import 'package:hive/hive.dart';
import 'package:news_app/config/constants/images_paths.dart';
part 'general_news_model.g.dart';

@HiveType(typeId: 2)
class GeneralNewsModel {
  @HiveField(0)
  String source;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String author;
  @HiveField(4)
  String url;
  @HiveField(5)
  String imageUrl;
  @HiveField(6)
  String publishedAt;
  @HiveField(7)
  String content;
  GeneralNewsModel({
    required this.source,
    required this.title,
    required this.description,
    required this.author,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
  });

  GeneralNewsModel.fromJson(Map<String, dynamic> json)
      : source = json['source']['name'] ?? '',
        title = json['title'] ?? '',
        description = json['description'] ?? 'No content available for this post!',
        author = json['author'] ?? 'Unknown',
        url = json['url'] ?? '',
        imageUrl = json['urlToImage'] ?? imageDownloadFailed,
        publishedAt = json['publishedAt'] ?? '',
        content = json['content'] ?? '';

  @override
  bool operator ==(Object other) => identical(this, other) || other is GeneralNewsModel && runtimeType == other.runtimeType && title == other.title;

  @override
  int get hashCode => title.hashCode;
}
