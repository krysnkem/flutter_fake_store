import 'package:equatable/equatable.dart';
import 'package:flutter_fake_store/data/models/product/product.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoadingAllProducts extends ProductsState {}

final class ProductsLoadingMoreProducts extends ProductsState {
  final List<Product> products;

  const ProductsLoadingMoreProducts({this.products = const []});

  @override
  List<Object> get props => [products];
}

final class ProductsLoaded extends ProductsState {
  final List<Product> products;

  const ProductsLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

final class ProductsError extends ProductsState {
  final String message;

  const ProductsError({required this.message});

  @override
  List<Object> get props => [message];
}

final class MoreProductsError extends ProductsState {
  final String message;
  final List<Product> products;

  const MoreProductsError({required this.message, required this.products});

  @override
  List<Object> get props => [message, products];
}
