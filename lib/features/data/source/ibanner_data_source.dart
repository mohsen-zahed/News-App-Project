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
        .get('https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=afb0edfa40d24b0bbf81f80225b27b28');
    List<BannersNewsModel> newsList = [];
    for (var element in (response.data['articles'] as List)) {
      newsList.add(BannersNewsModel.fromJson(element));
    }
    return newsList;
  }
}
