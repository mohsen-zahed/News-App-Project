import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app_project/features/data/models/banners_news_model.dart';
import 'package:news_app_project/packages/connectivity_plus_package/connectivity_plus_constants.dart';
import 'package:news_app_project/packages/hive_flutter_package/hive_flutter_package_constants.dart';

abstract class IBannerDataSource {
  Future<List<BannersNewsModel>> getBannersNews();
}

class BannerDataSourceImp implements IBannerDataSource {
  final Dio httpClient;

  BannerDataSourceImp({required this.httpClient});
  @override
  Future<List<BannersNewsModel>> getBannersNews() async {
    if (connectionStatusListener.isInternetConnected) {
      final response = await httpClient.get('https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=afb0edfa40d24b0bbf81f80225b27b28');
      if (response.data != null && response.data is Map<String, dynamic>) {
        final box = Hive.box<BannersNewsModel>(bannersNewsModelBoxName);
        // box.clear();
        for (var element in (response.data['articles'] as List)) {
          var bannersNewsModel = BannersNewsModel.fromJson(element);
          if (!box.values.contains(bannersNewsModel)) {
            box.add(bannersNewsModel);
          }
        }
      }
      List<BannersNewsModel> newsList = [];
      for (var element in (response.data['articles'] as List)) {
        newsList.add(BannersNewsModel.fromJson(element));
      }
      print('sourceFolder_net_status: ${connectionStatusListener.isInternetConnected}');
      print('sourceFolder: loaded from api');
      return newsList;
    } else {
      final box = Hive.box<BannersNewsModel>(bannersNewsModelBoxName).values.toList();
      List<BannersNewsModel> offlineNewsList = [];
      for (var element in box) {
        offlineNewsList.add(element);
      }
      print('sourceFolder_net_status: ${connectionStatusListener.isInternetConnected}');
      print('sourceFolder: loaded from database');
      return offlineNewsList;
    }
  }
}
