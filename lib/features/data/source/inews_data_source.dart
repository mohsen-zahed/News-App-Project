import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app_project/features/data/models/business_news_model.dart';
import 'package:news_app_project/features/data/models/general_news_model.dart';
import 'package:news_app_project/features/data/models/technology_news_model.dart';
import 'package:news_app_project/features/data/models/wall_street_news_model.dart';
import 'package:news_app_project/helpers/helper_functions.dart';

abstract class INewsDataSource {
  Future<List<TechnologyNewsModel>> getTechnologyNews();
  Future<List<WallStreetNewsModel>> getWallStreetNews();
  Future<List<BusinessNewsModel>> getBusinessNews();
  Future<List<GeneralNewsModel>> getAllNews();
}

class NewsDataSource implements INewsDataSource {
  final Dio httpClient;

  NewsDataSource({required this.httpClient});

  @override
  Future<List<TechnologyNewsModel>> getTechnologyNews() async {
    final response = await httpClient
        .get('https://newsapi.org/v2/everything?q=apple&from=2024-05-20&to=2024-05-20&sortBy=popularity&apiKey=3f1e9b5d74f7402b9515b7e859482502');
    final List<TechnologyNewsModel> technologyList = [];
    for (var element in (response.data['articles'] as List).reversed) {
      technologyList.add(TechnologyNewsModel.fromJson(element));
    }
    return technologyList;
  }

  @override
  Future<List<WallStreetNewsModel>> getWallStreetNews() async {
    final response = await httpClient.get('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=3f1e9b5d74f7402b9515b7e859482502');
    final List<WallStreetNewsModel> wallStreetList = [];
    for (var element in (response.data['articles'] as List).reversed) {
      wallStreetList.add(WallStreetNewsModel.fromJson(element));
    }
    return wallStreetList;
  }

  @override
  Future<List<BusinessNewsModel>> getBusinessNews() async {
    final response =
        await httpClient.get('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3f1e9b5d74f7402b9515b7e859482502');
    final List<BusinessNewsModel> businessList = [];
    for (var element in (response.data['articles'] as List).reversed) {
      businessList.add(BusinessNewsModel.fromJson(element));
    }
    return businessList;
  }

  @override
  Future<List<GeneralNewsModel>> getAllNews() async {
    final response = await httpClient.get('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=3f1e9b5d74f7402b9515b7e859482502');
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
  }
}
