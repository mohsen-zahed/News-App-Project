import 'package:news_app_project/features/data/models/news_model.dart';
import 'package:news_app_project/features/data/source/ibanner_data_source.dart';
import 'package:news_app_project/packages/dio/dio_package.dart';

final bannerRepository = BannerRepository(iBannerDataSource: BannerDataSourceImp(httpClient: httpClient));

abstract class IBannerRepository {
  Future<List<NewsModel>> getAllNews();
}

class BannerRepository extends IBannerRepository {
  final IBannerDataSource iBannerDataSource;

  BannerRepository({required this.iBannerDataSource});
  @override
  Future<List<NewsModel>> getAllNews() => iBannerDataSource.getAllNews();
}
