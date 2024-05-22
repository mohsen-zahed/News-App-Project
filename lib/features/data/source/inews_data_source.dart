import 'package:dio/dio.dart';
import 'package:news_app_project/features/data/models/business_news_model.dart';
import 'package:news_app_project/features/data/models/technology_news_model.dart';
import 'package:news_app_project/features/data/models/wall_street_news_model.dart';
import 'package:news_app_project/helpers/helper_functions.dart';

List<dynamic> techListA = [];
List<dynamic> wallStreetListA = [];
List<dynamic> businessListA = [];

abstract class INewsDataSource {
  Future<List<TechnologyNewsModel>> getTechnologyNews();
  Future<List<WallStreetNewsModel>> getWallStreetNews();
  Future<List<BusinessNewsModel>> getBusinessNews();
  List<dynamic> getAllNews();
}

class NewsDataSource implements INewsDataSource {
  final Dio httpClient;

  NewsDataSource({required this.httpClient});

  @override
  Future<List<TechnologyNewsModel>> getTechnologyNews() async {
    final response = await httpClient
        .get('https://newsapi.org/v2/everything?q=apple&from=2024-05-20&to=2024-05-20&sortBy=popularity&apiKey=3f1e9b5d74f7402b9515b7e859482502');
    final List<TechnologyNewsModel> technologyList = [];
    for (var element in (response.data['articles'] as List)) {
      technologyList.add(TechnologyNewsModel.fromJson(element));
    }
    techListA.add(technologyList);
    return technologyList;
  }

  @override
  Future<List<WallStreetNewsModel>> getWallStreetNews() async {
    final response = await httpClient.get('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=3f1e9b5d74f7402b9515b7e859482502');
    final List<WallStreetNewsModel> wallStreetList = [];
    for (var element in (response.data['articles'] as List)) {
      wallStreetList.add(WallStreetNewsModel.fromJson(element));
    }
    wallStreetListA.add(wallStreetList);
    return wallStreetList;
  }

  @override
  Future<List<BusinessNewsModel>> getBusinessNews() async {
    final response =
        await httpClient.get('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3f1e9b5d74f7402b9515b7e859482502');
    final List<BusinessNewsModel> businessList = [];
    for (var element in (response.data['articles'] as List)) {
      businessList.add(BusinessNewsModel.fromJson(element));
    }
    businessListA.add(businessList);
    return businessList;
  }

  @override
  List getAllNews() {
    return HelperFunctions.instance.combineLists(techListA, wallStreetListA, businessListA);
  }
}
