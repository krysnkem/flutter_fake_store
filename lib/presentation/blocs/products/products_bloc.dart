import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/data/models/product/product.dart';
import 'package:flutter_fake_store/data/models/result.dart';
import 'package:flutter_fake_store/data/repositories/data_repository.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_event.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_state.dart';
import 'package:injectable/injectable.dart';

@singleton
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final DataRepository _dataRepository;
  ProductsBloc(this._dataRepository) : super(ProductsInitial()) {
    on<GetAllProducts>(_getAllProducts);
    on<GetMoreProducts>(_onGetMoreProducts);
    on<ResetProducts>(_onResetProducts);
  }

  FutureOr<void> _getAllProducts(
      GetAllProducts event, Emitter<ProductsState> emit) async {
    emit(ProductsLoadingAllProducts());
    try {
      final result = await _dataRepository.getProducts();
      if (result is Success) {
        emit(
          ProductsLoaded(products: (result as Success).data as List<Product>),
        );
      } else if (result is Failure) {
        emit(ProductsError(message: (result as Failure).message));
      }
    } catch (e, stacktrace) {
      emit(ProductsError(message: e.toString()));
      log('Error geting all products: $e \n $stacktrace');
    }
  }

  FutureOr<void> _onGetMoreProducts(
      GetMoreProducts event, Emitter<ProductsState> emit) async {
    if (state is ProductsLoadingMoreProducts) {
      return;
    }
    final productList = <Product>[];
    if (state is ProductsLoaded) {
      productList.addAll((state as ProductsLoaded).products);
    }
    emit(ProductsLoadingMoreProducts(products: productList));
    try {
      final result = await _dataRepository.getProducts();
      if (result is Success) {
        final products = (result as Success).data as List<Product>;
        productList.addAll(products);
        emit(ProductsLoaded(products: productList));
      } else if (result is Failure) {
        emit(
          MoreProductsError(
            message: (result as Failure).message,
            products: productList,
          ),
        );
      }
    } catch (e) {
      // emit(ProductsError(message: e.toString()));
      emit(
        MoreProductsError(
          message: e.toString(),
          products: productList,
        ),
      );
      log('Error geting more products: $e');
    }
  }

  FutureOr<void> _onResetProducts(
      ResetProducts event, Emitter<ProductsState> emit) {
    emit(ProductsInitial());
  }
}
