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
  Future<List<TechnologyNewsModel>> getTechnologyNews();

  Future<List<WallStreetNewsModel>> getWallStreetNews();

  Future<List<BusinessNewsModel>> getBusinessNews();

  Future<List<GeneralNewsModel>> getAllNews();
}

class NewsDataSource implements INewsDataSource {
  NewsDataSource({required this.httpClient});

  final Dio httpClient;

  @override
  Future<List<GeneralNewsModel>> getAllNews() async {
    if (connectionStatusListener.isInternetConnected) {
      final response = await httpClient.get('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=afb0edfa40d24b0bbf81f80225b27b28');
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
      final List<GeneralNewsModel> generalNewsList = [];
      for (var i = 0; i < (response.data['articles'] as List).length; i++) {
        String imageType = helperFunctions.getFileType(response.data['articles'][i]['urlToImage']);
        if (imageType.contains('webp')) {
          debugPrint(imageType);
          continue;
        } else if (imageType.contains('jpg') || imageType.contains('jpeg') || imageType.contains('png') || imageType.contains('JPEG')) {
          generalNewsList.add(GeneralNewsModel.fromJson(response.data['articles'][i]));
        }
      }
      return generalNewsList;
    } else {
      final box = Hive.box<GeneralNewsModel>(generalNewsModelBoxName).values.toList();
      List<GeneralNewsModel> offlineGeneralNewsList = [];
      for (var element in box) {
        offlineGeneralNewsList.add(element);
      }
      return offlineGeneralNewsList;
    }
  }

  @override
  Future<List<BusinessNewsModel>> getBusinessNews() async {
    if (connectionStatusListener.isInternetConnected) {
      final response = await httpClient.get('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=afb0edfa40d24b0bbf81f80225b27b28');
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
      final List<BusinessNewsModel> businessList = [];
      for (var element in (response.data['articles'] as List).reversed) {
        businessList.add(BusinessNewsModel.fromJson(element));
      }
      return businessList;
    } else {
      final box = Hive.box<BusinessNewsModel>(businessNewsModelBoxName).values.toList();
      List<BusinessNewsModel> offlineBusinessList = [];
      for (var element in box) {
        offlineBusinessList.add(element);
      }
      return offlineBusinessList;
    }
  }

  @override
  Future<List<TechnologyNewsModel>> getTechnologyNews() async {
    if (connectionStatusListener.isInternetConnected) {
      final response = await httpClient
          .get('https://newsapi.org/v2/everything?q=apple&from=2024-05-21&to=2024-05-21&sortBy=popularity&apiKey=afb0edfa40d24b0bbf81f80225b27b28');
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
      final List<TechnologyNewsModel> technologyList = [];
      for (var element in (response.data['articles'] as List).reversed) {
        technologyList.add(TechnologyNewsModel.fromJson(element));
      }
      return technologyList;
    } else {
      final box = Hive.box<TechnologyNewsModel>(technologyNewsModelBoxName).values.toList();
      List<TechnologyNewsModel> offlineTechnologyList = [];
      for (var element in box) {
        offlineTechnologyList.add(element);
      }
      return offlineTechnologyList;
    }
  }

  @override
  Future<List<WallStreetNewsModel>> getWallStreetNews() async {
    if (connectionStatusListener.isInternetConnected) {
      final response = await httpClient.get('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=afb0edfa40d24b0bbf81f80225b27b28');
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
      final List<WallStreetNewsModel> wallStreetList = [];
      for (var element in (response.data['articles'] as List).reversed) {
        wallStreetList.add(WallStreetNewsModel.fromJson(element));
      }
      return wallStreetList;
    } else {
      final box = Hive.box<WallStreetNewsModel>(wallStreetNewsModelBoxName).values.toList();
      List<WallStreetNewsModel> offlineWallStreetList = [];
      for (var element in box) {
        offlineWallStreetList.add(element);
      }
      return offlineWallStreetList;
    }
  }
}
