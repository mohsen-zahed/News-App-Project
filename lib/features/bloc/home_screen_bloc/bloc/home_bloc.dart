import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_project/features/data/models/banners_news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_project/features/data/models/business_news_model.dart';
import 'package:news_app_project/features/data/models/general_news_model.dart';
import 'package:news_app_project/features/data/models/technology_news_model.dart';
import 'package:news_app_project/features/data/models/wall_street_news_model.dart';
import 'package:news_app_project/features/data/repository/ibanner_repository.dart';
import 'package:news_app_project/features/data/repository/inews_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

bool isConnected = false;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository iBannerRepository;
  final INewsRepository iNewsRepository;
  HomeBloc(this.iBannerRepository, this.iNewsRepository) : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefresh) {
        emit(HomeLoading());
        // if (isConnected) {
        try {
          final bannersResult = await iBannerRepository.getAllBanners();
          final technologyResult = await iNewsRepository.getTechnologyNews();
          final wallStreetResult = await iNewsRepository.getWallStreetNews();
          final businessResult = await iNewsRepository.getBusinessNews();
          final allNewsResult = await iNewsRepository.getAllNews();
          emit(HomeSuccess(
            bannersList: bannersResult,
            technologyList: technologyResult,
            wallStreetList: wallStreetResult,
            businessNewsList: businessResult,
            generalNewsList: allNewsResult,
          ));
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(const HomeFailed(exception: 'Something went wrong, please try again in the next 24 hours!'));
          } else if (e.type == DioExceptionType.connectionError) {
            emit(const HomeFailed(exception: 'Please check your network and try again!'));
          } else if (e.type == DioExceptionType.connectionTimeout) {
            emit(const HomeFailed(exception: 'Request timed out, try again later!'));
          } else if (e.type == DioExceptionType.sendTimeout) {
            emit(const HomeFailed(exception: 'Request timed out, try again later!'));
          } else if (e.type == DioExceptionType.unknown) {
            emit(const HomeFailed(exception: 'There is an unknown problem keeping you from sending requests!'));
          } else {
            emit(const HomeFailed(exception: 'Something went wrong!'));
          }
        }
        // } else {
        //   try {
        //     final banners = Hive.box<BannersNewsModel>(bannersNewsModelBoxName).values.toList();
        //     final business = Hive.box<BusinessNewsModel>(businessNewsModelBoxName).values.toList();
        //     final general = Hive.box<GeneralNewsModel>(generalNewsModelBoxName).values.toList();
        //     final technology = Hive.box<TechnologyNewsModel>(technologyNewsModelBoxName).values.toList();
        //     final wallStreet = Hive.box<WallStreetNewsModel>(wallStreetNewsModelBoxName).values.toList();
        //     emit(HomeSuccess(
        //       bannersList: banners,
        //       technologyList: technology,
        //       wallStreetList: wallStreet,
        //       businessNewsList: business,
        //       generalNewsList: general,
        //     ));
        //   } on HiveError catch (e) {
        //     emit(HomeFailed(exception: e.message.toString()));
        //   }
        // }
      }
    });
  }
}
