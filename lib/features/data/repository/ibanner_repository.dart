import 'package:news_app_project/features/data/models/banners_news_model.dart';
import 'package:news_app_project/features/data/source/ibanner_data_source.dart';
import 'package:news_app_project/packages/dio_package/dio_package.dart';

final bannerRepository = BannerRepository(iBannerDataSource: BannerDataSourceImp(httpClient: httpClient));

abstract class IBannerRepository {
  Future<List<BannersNewsModel>> getAllBanners();
}

class BannerRepository implements IBannerRepository {
  final IBannerDataSource iBannerDataSource;

  BannerRepository({required this.iBannerDataSource});
  @override
  Future<List<BannersNewsModel>> getAllBanners() => iBannerDataSource.getBannersNews();
}
