import 'package:dio/dio.dart';
import 'package:news_app_project/features/data/models/banners_news_model.dart';

abstract class IBannerDataSource {
  Future<List<BannersNewsModel>> getBannersNews();
}

class BannerDataSourceImp implements IBannerDataSource {
  final Dio httpClient;

  BannerDataSourceImp({required this.httpClient});
  @override
  Future<List<BannersNewsModel>> getBannersNews() async {
    final response = await httpClient
        .get('https://gnews.io/api/v4/top-headlines?category=general&lang=en&country=us&max=10&apikey=15f591ec0e1ad69bcd838e6eff3e0ed0');
    List<BannersNewsModel> newsList = [];
    for (var element in (response.data['articles'] as List)) {
      newsList.add(BannersNewsModel.fromJson(element));
    }
    return newsList;
  }
}
