import 'package:equatable/equatable.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

final class GetAllProducts extends ProductsEvent {
  const GetAllProducts();
  @override
  List<Object> get props => [];
}

final class GetMoreProducts extends ProductsEvent {
  const GetMoreProducts();
  @override
  List<Object> get props => [];
}

final class ResetProducts extends ProductsEvent {
  const ResetProducts();
}
