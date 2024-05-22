import 'package:news_app_project/features/data/models/business_news_model.dart';
import 'package:news_app_project/features/data/models/technology_news_model.dart';
import 'package:news_app_project/features/data/models/wall_street_news_model.dart';
import 'package:news_app_project/features/data/source/inews_data_source.dart';
import 'package:news_app_project/packages/dio_package/dio_package.dart';

final newsRepository = NewsRepository(iNewsDataSource: NewsDataSource(httpClient: httpClient));

abstract class INewsRepository {
  Future<List<TechnologyNewsModel>> getTechnologyNews();
  Future<List<WallStreetNewsModel>> getWallStreetNews();
  Future<List<BusinessNewsModel>> getBusinessNews();
  List<dynamic> getAllNews();
}

class NewsRepository implements INewsRepository {
  final INewsDataSource iNewsDataSource;

  NewsRepository({required this.iNewsDataSource});
  @override
  Future<List<TechnologyNewsModel>> getTechnologyNews() => iNewsDataSource.getTechnologyNews();

  @override
  Future<List<WallStreetNewsModel>> getWallStreetNews() => iNewsDataSource.getWallStreetNews();

  @override
  Future<List<BusinessNewsModel>> getBusinessNews() => iNewsDataSource.getBusinessNews();

  @override
  List getAllNews() => iNewsDataSource.getAllNews();
}
