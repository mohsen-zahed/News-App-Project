part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<BannersNewsModel> bannersList;
  final List<GeneralNewsModel> allNewsList;
  final List<WallStreetNewsModel> wallStreetList;
  final List<TechnologyNewsModel> technologyList;
  final List<BusinessNewsModel> businessNewsList;

  const HomeSuccess({
    required this.bannersList,
    required this.allNewsList,
    required this.wallStreetList,
    required this.technologyList,
    required this.businessNewsList,
  });
  @override
  List<Object> get props => [bannersList, allNewsList, wallStreetList, technologyList, businessNewsList];
}

final class HomeFailed extends HomeState {
  final String exception;

  const HomeFailed({required this.exception});

  @override
  List<Object> get props => [exception];
}
