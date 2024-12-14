part of 'product_list_bloc.dart';

@immutable
abstract class ProductListState {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListLoading extends ProductListState {}

class ProductListSuccess extends ProductListState {
  final List<ProductData> products;
  final int sort;
  final List<String> sortName;

  const ProductListSuccess(this.products, this.sort, this.sortName);

  @override
  List<Object> get props => [sort,products,sortName];
}

class ProductListError extends ProductListState {
  final AppException exception;
  const ProductListError(this.exception);

  @override
  List<Object> get props => [exception];
}
