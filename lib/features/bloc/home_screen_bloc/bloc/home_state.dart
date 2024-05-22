part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<BannersNewsModel> bannersList;
  final List<TechnologyNewsModel> technologyList;
  final List<WallStreetNewsModel> wallStreetList;
  final List<BusinessNewsModel> businessNewsList;
  final List<GeneralNewsModel> generalNewsList;

  const HomeSuccess({
    required this.generalNewsList,
    required this.businessNewsList,
    required this.wallStreetList,
    required this.technologyList,
    required this.bannersList,
  });
  @override
  List<Object> get props => [generalNewsList, bannersList, technologyList, wallStreetList, businessNewsList];
}

final class HomeFailed extends HomeState {
  final String exception;

  const HomeFailed({required this.exception});

  @override
  List<Object> get props => [exception];
}
