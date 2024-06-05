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
      final List<BannersNewsModel> bannersNewsList = [];
      for (var i = 0; i < (response.data['articles'] as List).length; i++) {
        //* To store in local database for accessing later with no connection...
        String? imageType = helperFunctions.getFileType(response.data['articles'][i]['urlToImage']);
        if (response.data != null || response.data.isNotEmpty) {
          final box = Hive.box<BannersNewsModel>(bannersNewsModelBoxName);
          box.clear();
          try {
            if (imageType == '' || imageType.contains('webp') || imageType.contains('gif')) {
              debugPrint('Hive imageType is not valid: $imageType');
              continue;
            } else if (imageType.contains('jpg') || imageType.contains('jpeg') || imageType.contains('png') || imageType.contains('JPEG')) {
              var bannersNewsModel = BannersNewsModel.fromJson(response.data['articles'][i]);
              if (!box.values.contains(bannersNewsModel)) {
                box.add(bannersNewsModel);
              }
            }
          } catch (e) {
            debugPrint('Hive box continue: $e');
            continue;
          }
          //* Ends here...
          //* Online process occures here...
          try {
            if (imageType == '' || imageType.contains('webp') || imageType.contains('gif')) {
              debugPrint('imageType is not valid: $imageType');
              continue;
            } else if (imageType.contains('jpg') || imageType.contains('jpeg') || imageType.contains('png') || imageType.contains('JPEG')) {
              bannersNewsList.add(BannersNewsModel.fromJson(response.data['articles'][i]));
            }
          } catch (e) {
            debugPrint(e.toString());
            continue;
          }
        } else {
          //* Offline process when response is null or empty...
          final box = Hive.box<BannersNewsModel>(bannersNewsModelBoxName).values.toList();
          List<BannersNewsModel> offlineBannersNewsList = [];
          for (var element in box) {
            offlineBannersNewsList.add(element);
          }
          return offlineBannersNewsList;
          //* Ends here...
        }
      }
      return bannersNewsList;
      //* Ends here...
    } else {
      //* Offline process when user is not connected...
      final box = Hive.box<BannersNewsModel>(bannersNewsModelBoxName).values.toList();
      List<BannersNewsModel> offlineBannersNewsList = [];
      for (var element in box) {
        offlineBannersNewsList.add(element);
      }
      return offlineBannersNewsList;
      //* Ends here...
    }
  }
}
