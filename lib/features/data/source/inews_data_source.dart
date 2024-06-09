import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/features/data/models/business_news_model.dart';
import 'package:news_app/features/data/models/general_news_model.dart';
import 'package:news_app/features/data/models/technology_news_model.dart';
import 'package:news_app/features/data/models/wall_street_news_model.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/packages/connectivity_plus_package/connectivity_plus_constants.dart';
import 'package:news_app/packages/hive_flutter_package/hive_flutter_package_constants.dart';

abstract class INewsDataSource {
  Future<List<GeneralNewsModel>> getAllNews();

  Future<List<WallStreetNewsModel>> getWallStreetNews();

  Future<List<TechnologyNewsModel>> getTechnologyNews();

  Future<List<BusinessNewsModel>> getBusinessNews();
}

class NewsDataSource implements INewsDataSource {
  NewsDataSource({required this.httpClient});
  final Dio httpClient;

  @override
  Future<List<GeneralNewsModel>> getAllNews() async {
    if (connectionStatusListener.isInternetConnected) {
      final response = await httpClient.get('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=3f1e9b5d74f7402b9515b7e859482502');
      final List<GeneralNewsModel> allNewsList = [];
      for (var i = 0; i < (response.data['articles'] as List).length; i++) {
        //* To store in local database for accessing later with no connection...
        String? imageType = helperFunctions.getFileType(response.data['articles'][i]['urlToImage']);
        if (response.data != null || response.data.isNotEmpty) {
          final box = Hive.box<GeneralNewsModel>(generalNewsModelBoxName);
          // box.clear();
          try {
            if (imageType == '' || imageType.contains('webp') || imageType.contains('gif')) {
              debugPrint('Hive imageType is not valid: $imageType');
              continue;
            } else if (imageType.contains('jpg') || imageType.contains('jpeg') || imageType.contains('png') || imageType.contains('JPEG')) {
              var generalNewsModel = GeneralNewsModel.fromJson(response.data['articles'][i]);
              if (!box.values.contains(generalNewsModel)) {
                box.add(generalNewsModel);
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
              allNewsList.add(GeneralNewsModel.fromJson(response.data['articles'][i]));
            }
          } catch (e) {
            debugPrint(e.toString());
            continue;
          }
        } else {
          //* Offline process when response is null or empty...
          final box = Hive.box<GeneralNewsModel>(generalNewsModelBoxName).values.toList();
          List<GeneralNewsModel> offlineGeneralNewsList = [];
          for (var element in box) {
            offlineGeneralNewsList.add(element);
          }
          return offlineGeneralNewsList;
          //* Ends here...
        }
      }
      return allNewsList;
      //* Ends here...
    } else {
      //* Offline process when user is not connected...
      final box = Hive.box<GeneralNewsModel>(generalNewsModelBoxName).values.toList();
      List<GeneralNewsModel> offlineGeneralNewsList = [];
      for (var element in box) {
        offlineGeneralNewsList.add(element);
      }
      return offlineGeneralNewsList;
      //* Ends here...
    }
  }

  @override
  Future<List<WallStreetNewsModel>> getWallStreetNews() async {
    if (connectionStatusListener.isInternetConnected) {
      final response = await httpClient.get('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=3f1e9b5d74f7402b9515b7e859482502');
      final List<WallStreetNewsModel> wallStreetNewsList = [];
      for (var i = 0; i < (response.data['articles'] as List).length; i++) {
        //* To store in local database for accessing later with no connection...
        String? imageType = helperFunctions.getFileType(response.data['articles'][i]['urlToImage']);
        if (response.data != null || response.data.isNotEmpty) {
          final box = Hive.box<WallStreetNewsModel>(wallStreetNewsModelBoxName);
          // box.clear();
          try {
            if (imageType == '' || imageType.contains('webp') || imageType.contains('gif')) {
              debugPrint('Hive imageType is not valid: $imageType');
              continue;
            } else if (imageType.contains('jpg') || imageType.contains('jpeg') || imageType.contains('png') || imageType.contains('JPEG')) {
              var wallStreetNewsModel = WallStreetNewsModel.fromJson(response.data['articles'][i]);
              if (!box.values.contains(wallStreetNewsModel)) {
                box.add(wallStreetNewsModel);
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
              wallStreetNewsList.add(WallStreetNewsModel.fromJson(response.data['articles'][i]));
            }
          } catch (e) {
            debugPrint(e.toString());
            continue;
          }
        } else {
          //* Offline process when response is null or empty...
          final box = Hive.box<WallStreetNewsModel>(wallStreetNewsModelBoxName).values.toList();
          List<WallStreetNewsModel> offlineWallStreetNewsList = [];
          for (var element in box) {
            offlineWallStreetNewsList.add(element);
          }
          return offlineWallStreetNewsList;
          //* Ends here...
        }
      }
      return wallStreetNewsList;
      //* Ends here...
    } else {
      //* Offline process when user is not connected...
      final box = Hive.box<WallStreetNewsModel>(wallStreetNewsModelBoxName).values.toList();
      List<WallStreetNewsModel> offlineWallStreetNewsList = [];
      for (var element in box) {
        offlineWallStreetNewsList.add(element);
      }
      return offlineWallStreetNewsList;
      //* Ends here...
    }
  }

  @override
  Future<List<TechnologyNewsModel>> getTechnologyNews() async {
    if (connectionStatusListener.isInternetConnected) {
      final response = await httpClient
          .get('https://newsapi.org/v2/everything?q=apple&from=2024-06-08&to=2024-06-08&sortBy=popularity&apiKey=3f1e9b5d74f7402b9515b7e859482502');
      final List<TechnologyNewsModel> technologyNewsList = [];
      for (var i = 0; i < (response.data['articles'] as List).length; i++) {
        //* To store in local database for accessing later with no connection...
        String? imageType = helperFunctions.getFileType(response.data['articles'][i]['urlToImage']);
        if (response.data != null || response.data.isNotEmpty) {
          final box = Hive.box<TechnologyNewsModel>(technologyNewsModelBoxName);
          // box.clear();
          try {
            if (imageType == '' || imageType.contains('webp') || imageType.contains('gif')) {
              debugPrint('Hive imageType is not valid: $imageType');
              continue;
            } else if (imageType.contains('jpg') || imageType.contains('jpeg') || imageType.contains('png') || imageType.contains('JPEG')) {
              var technologyNewsModel = TechnologyNewsModel.fromJson(response.data['articles'][i]);
              if (!box.values.contains(technologyNewsModel)) {
                box.add(technologyNewsModel);
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
              technologyNewsList.add(TechnologyNewsModel.fromJson(response.data['articles'][i]));
            }
          } catch (e) {
            debugPrint(e.toString());
            continue;
          }
        } else {
          //* Offline process when response is null or empty...
          final box = Hive.box<TechnologyNewsModel>(technologyNewsModelBoxName).values.toList();
          List<TechnologyNewsModel> offlineTechnologyNewsList = [];
          for (var element in box) {
            offlineTechnologyNewsList.add(element);
          }
          return offlineTechnologyNewsList;
          //* Ends here...
        }
      }
      return technologyNewsList;
      //* Ends here...
    } else {
      //* Offline process when user is not connected...
      final box = Hive.box<TechnologyNewsModel>(technologyNewsModelBoxName).values.toList();
      List<TechnologyNewsModel> offlineTechnologyNewsList = [];
      for (var element in box) {
        offlineTechnologyNewsList.add(element);
      }
      return offlineTechnologyNewsList;
      //* Ends here...
    }
  }

  @override
  Future<List<BusinessNewsModel>> getBusinessNews() async {
    if (connectionStatusListener.isInternetConnected) {
      final response =
          await httpClient.get('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3f1e9b5d74f7402b9515b7e859482502');
      final List<BusinessNewsModel> businessNewsList = [];
      for (var i = 0; i < (response.data['articles'] as List).length; i++) {
        //* To store in local database for accessing later with no connection...
        String? imageType = helperFunctions.getFileType(response.data['articles'][i]['urlToImage']);
        if (response.data != null || response.data.isNotEmpty) {
          final box = Hive.box<BusinessNewsModel>(businessNewsModelBoxName);
          // box.clear();
          try {
            if (imageType == '' || imageType.contains('webp') || imageType.contains('gif')) {
              debugPrint('Hive imageType is not valid: $imageType');
              continue;
            } else if (imageType.contains('jpg') || imageType.contains('jpeg') || imageType.contains('png') || imageType.contains('JPEG')) {
              var businessNewsModel = BusinessNewsModel.fromJson(response.data['articles'][i]);
              if (!box.values.contains(businessNewsModel)) {
                box.add(businessNewsModel);
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
              businessNewsList.add(BusinessNewsModel.fromJson(response.data['articles'][i]));
            }
          } catch (e) {
            debugPrint(e.toString());
            continue;
          }
        } else {
          //* Offline process when response is null or empty...
          final box = Hive.box<BusinessNewsModel>(businessNewsModelBoxName).values.toList();
          List<BusinessNewsModel> offlineBusinessNewsList = [];
          for (var element in box) {
            offlineBusinessNewsList.add(element);
          }
          return offlineBusinessNewsList;
          //* Ends here...
        }
      }
      return businessNewsList;
      //* Ends here...
    } else {
      //* Offline process when user is not connected...
      final box = Hive.box<BusinessNewsModel>(businessNewsModelBoxName).values.toList();
      List<BusinessNewsModel> offlineBusinessNewsList = [];
      for (var element in box) {
        offlineBusinessNewsList.add(element);
      }
      return offlineBusinessNewsList;
      //* Ends here...
    }
  }
}
