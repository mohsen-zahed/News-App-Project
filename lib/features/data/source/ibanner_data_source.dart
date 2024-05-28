import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/features/data/models/banners_news_model.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/packages/connectivity_plus_package/connectivity_plus_constants.dart';
import 'package:news_app/packages/hive_flutter_package/hive_flutter_package_constants.dart';

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
      List<BannersNewsModel> bannersNewsList = [];
      for (var i = 0; i < (response.data['articles'] as List).length; i++) {
        try {
          String imageType = helperFunctions.getFileType(response.data['articles'][i]['urlToImage']);
          final imageAccess = await httpClient.request(imageType);
          if (imageAccess.statusCode == 200) {
            if (imageType.contains('webp') || imageType.contains('gif')) {
              debugPrint('imageType is not valid: $imageType');
              continue;
            } else if (imageType.contains('jpg') || imageType.contains('jpeg') || imageType.contains('png') || imageType.contains('JPEG')) {
              bannersNewsList.add(BannersNewsModel.fromJson(response.data['articles'][i]));
            }
          } else {
            continue;
          }
        } catch (e) {
          debugPrint(e.toString());
          continue;
        }
      }
      print('sourceFolder_net_status: ${connectionStatusListener.isInternetConnected}');
      print('sourceFolder: loaded from api');
      return bannersNewsList;
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
