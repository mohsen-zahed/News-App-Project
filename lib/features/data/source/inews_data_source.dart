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
      //* To store in local database for accessing later with no connection...
      if (response.data != null || response.data.isNotEmpty) {
        final box = Hive.box<GeneralNewsModel>(generalNewsModelBoxName);
        // box.clear();
        for (var element in (response.data['articles'] as List)) {
          var generalNewsModel = GeneralNewsModel.fromJson(element);
          if (!box.values.contains(generalNewsModel)) {
            box.add(generalNewsModel);
          }
        }
      }
      //* Ends here...
      //* Online process occures here...
      final List<GeneralNewsModel> allNewsList = [];
      for (var i = 0; i < (response.data['articles'] as List).length; i++) {
        try {
          String imageType = helperFunctions.getFileType(response.data['articles'][i]['urlToImage']);

          if (imageType.contains('webp') || imageType.contains('gif')) {
            debugPrint('imageType is not valid: $imageType');
            continue;
          } else if (imageType.contains('jpg') || imageType.contains('jpeg') || imageType.contains('png') || imageType.contains('JPEG')) {
            allNewsList.add(GeneralNewsModel.fromJson(response.data['articles'][i]));
          }
        } catch (e) {
          debugPrint(e.toString());
          continue;
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
      //* To store in local database for accessing later with no connection...
      if (response.data != null || response.data.isNotEmpty) {
        final box = Hive.box<WallStreetNewsModel>(wallStreetNewsModelBoxName);
        // box.clear();
        for (var element in (response.data['articles'] as List)) {
          var wallStreetNewsModel = WallStreetNewsModel.fromJson(element);
          if (!box.values.contains(wallStreetNewsModel)) {
            box.add(wallStreetNewsModel);
          }
        }
      }
      //* Ends here...
      //* Online process occures here...
      final List<WallStreetNewsModel> wallStreetList = [];
      for (var i = 0; i < (response.data['articles'] as List).length; i++) {
        try {
          String imageType = helperFunctions.getFileType(response.data['articles'][i]['urlToImage']);

          if (imageType.contains('webp') || imageType.contains('gif')) {
            debugPrint('imageType is not valid: $imageType');
            continue;
          } else if (imageType.contains('jpg') || imageType.contains('jpeg') || imageType.contains('png') || imageType.contains('JPEG')) {
            wallStreetList.add(WallStreetNewsModel.fromJson(response.data['articles'][i]));
          }
        } catch (e) {
          debugPrint(e.toString());
          continue;
        }
      }
      return wallStreetList;
      //* Ends here...
    } else {
      //* Offline process when user is not connected...
      final box = Hive.box<WallStreetNewsModel>(wallStreetNewsModelBoxName).values.toList();
      List<WallStreetNewsModel> offlineWallStreetList = [];
      for (var element in box) {
        offlineWallStreetList.add(element);
      }
      return offlineWallStreetList;
      //* Ends here...
    }
  }

  @override
  Future<List<TechnologyNewsModel>> getTechnologyNews() async {
    if (connectionStatusListener.isInternetConnected) {
      final response = await httpClient
          .get('https://newsapi.org/v2/everything?q=apple&from=2024-05-21&to=2024-05-21&sortBy=popularity&apiKey=3f1e9b5d74f7402b9515b7e859482502');

      //* To store in local database for accessing later with no connection...
      if (response.data != null || response.data.isNotEmpty) {
        final box = Hive.box<TechnologyNewsModel>(technologyNewsModelBoxName);
        // box.clear();
        for (var element in (response.data['articles'] as List)) {
          var technologyNewsModel = TechnologyNewsModel.fromJson(element);
          if (!box.values.contains(technologyNewsModel)) {
            box.add(technologyNewsModel);
          }
        }
      }
      //* Ends here...
      //* Online process occures here...
      final List<TechnologyNewsModel> technologyList = [];
      for (var i = 0; i < (response.data['articles'] as List).length; i++) {
        try {
          String imageType = helperFunctions.getFileType(response.data['articles'][i]['urlToImage']);

          if (imageType.contains('webp') || imageType.contains('gif')) {
            debugPrint('imageType is not valid: $imageType');
            continue;
          } else if (imageType.contains('jpg') || imageType.contains('jpeg') || imageType.contains('png') || imageType.contains('JPEG')) {
            technologyList.add(TechnologyNewsModel.fromJson(response.data['articles'][i]));
          }
        } catch (e) {
          debugPrint(e.toString());
          continue;
        }
      }
      return technologyList;
      //* Ends here...
    } else {
      //* Offline process when user is not connected...
      final box = Hive.box<TechnologyNewsModel>(technologyNewsModelBoxName).values.toList();
      List<TechnologyNewsModel> offlineTechnologyList = [];
      for (var element in box) {
        offlineTechnologyList.add(element);
      }
      return offlineTechnologyList;
      //* Ends here
    }
  }

  @override
  Future<List<BusinessNewsModel>> getBusinessNews() async {
    if (connectionStatusListener.isInternetConnected) {
      final response =
          await httpClient.get('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3f1e9b5d74f7402b9515b7e859482502');

      //* To store in local database for accessing later with no connection...
      if (response.data != null || response.data.isNotEmpty) {
        final box = Hive.box<BusinessNewsModel>(businessNewsModelBoxName);
        // box.clear();
        for (var element in (response.data['articles'] as List)) {
          var businessNewsModel = BusinessNewsModel.fromJson(element);
          if (!box.values.contains(businessNewsModel)) {
            box.add(businessNewsModel);
          }
        }
      }
      //* Ends here...
      //* Online process occures here...
      final List<BusinessNewsModel> businessList = [];
      for (var i = 0; i < (response.data['articles'] as List).length; i++) {
        try {
          String imageType = helperFunctions.getFileType(response.data['articles'][i]['urlToImage']);

          if (imageType.contains('webp') || imageType.contains('gif')) {
            debugPrint('imageType is not valid: $imageType');
            continue;
          } else if (imageType.contains('jpg') || imageType.contains('jpeg') || imageType.contains('png') || imageType.contains('JPEG')) {
            businessList.add(BusinessNewsModel.fromJson(response.data['articles'][i]));
          }
        } catch (e) {
          debugPrint(e.toString());
          continue;
        }
      }
      return businessList;
      //* Ends here...
    } else {
      //* Offline process when user is not connected...
      final box = Hive.box<BusinessNewsModel>(businessNewsModelBoxName).values.toList();
      List<BusinessNewsModel> offlineBusinessList = [];
      for (var element in box) {
        offlineBusinessList.add(element);
      }
      return offlineBusinessList;
      //* Ends here...
    }
  }
}
