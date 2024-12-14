import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:project_seven_nike_welcomeback/common/exceptsion.dart';
import 'package:project_seven_nike_welcomeback/data/repo/cart_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ICartRepository cartRepository;
  ProductBloc(this.cartRepository) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is CartAddButtonClick){
        try{
          emit(ProductAddToCartButtonLoading());
          await Future.delayed(const Duration(seconds: 2));
          final result =  cartRepository.add(event.productId);
          await cartRepository.count();
          emit(ProductAddToCartSuccess());
        }catch(e){
          emit(ProductAddToCartError(AppException()));
        }
      }
    });
  }
}
