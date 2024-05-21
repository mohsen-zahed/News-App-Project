import 'package:dio/dio.dart';
import 'package:news_app_project/features/data/models/news_model.dart';

abstract class IBannerDataSource {
  Future<List<NewsModel>> getAllNews();
}

class BannerDataSourceImp extends IBannerDataSource {
  final Dio httpClient;

  BannerDataSourceImp({required this.httpClient});
  @override
  Future<List<NewsModel>> getAllNews() async {
    final response = await httpClient
        .get('https://gnews.io/api/v4/top-headlines?category=general&lang=en&country=us&max=10&apikey=15f591ec0e1ad69bcd838e6eff3e0ed0');
    List<NewsModel> newsList = [];
    for (var element in (response.data['articles'] as List)) {
      newsList.add(NewsModel.fromJson(element));
    }
    return newsList;
  }
}
