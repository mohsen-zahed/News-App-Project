import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_project/features/data/models/news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_project/features/data/repository/ibanner_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository iBannerRepository;
  HomeBloc(this.iBannerRepository) : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted) {
        emit(HomeLoading());
        try {
          final result = await iBannerRepository.getAllNews();
          emit(HomeSuccess(newsList: result));
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(HomeFailed(exception: 'bad response'));
          } else if (e.type == DioExceptionType.connectionError) {
            emit(HomeFailed(exception: ''));
          } else if (e.type == DioExceptionType.connectionTimeout) {
            emit(HomeFailed(exception: ''));
          } else if (e.type == DioExceptionType.sendTimeout) {
            emit(HomeFailed(exception: ''));
          } else if (e.type == DioExceptionType.unknown) {
            emit(HomeFailed(exception: ''));
          } else {
            emit(HomeFailed(exception: ''));
          }
        }
      }
    });
  }
}
