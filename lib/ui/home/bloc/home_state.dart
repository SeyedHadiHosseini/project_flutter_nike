part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable  {


const HomeState();

@override
List<Object> get props => [];

}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {

  final List<BannerData> banner;
  final List<ProductData> latesProducts;
  final List<ProductData> popularProducts;

  const HomeSuccess ({required this.banner , required this.latesProducts , required this.popularProducts });


}

class HomeError extends HomeState  {
final AppException exception ;

const HomeError({required this.exception });
@override
// با override کردن props کاری میکنه که exception بالا اگر تکراری باشه دوباره ساخته نشه
  List<Object> get props => [exception];

}


