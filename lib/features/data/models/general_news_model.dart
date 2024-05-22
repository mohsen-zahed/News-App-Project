class GeneralNewsModel {
  String source;
  String title;
  String description;
  String author;
  String url;
  String imageUrl;
  String publishedAt;
  String content;
  GeneralNewsModel.fromJson(Map<String, dynamic> json)
      : source = json['source']['name'] ?? '',
        title = json['title'] ?? '',
        description = json['description'] ?? 'No content available for this post!',
        author = json['author'] ?? 'Unknown',
        url = json['url'] ?? '',
        imageUrl = json['urlToImage'],
        publishedAt = json['publishedAt'] ?? '',
        content = json['content'] ?? '';
}
