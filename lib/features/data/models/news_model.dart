class NewsModel {
  String title;
  String description;
  String content;
  String newsLink;
  String imageUrl;
  String publishedDate;
  String sourceName;
  String sourceUrl;

  NewsModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        content = json['content'],
        newsLink = json['url'],
        imageUrl = json['image'],
        publishedDate = json['publishedAt'],
        sourceName = json['source']['name'],
        sourceUrl = json['source']['url'];
}
