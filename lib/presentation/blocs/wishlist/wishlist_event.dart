import 'package:equatable/equatable.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

final class GetWishlist extends WishlistEvent {
  const GetWishlist();
}

final class ResetWishlist extends WishlistEvent {
  const ResetWishlist();
}

final class WishlistProductAdded extends WishlistEvent {
  const WishlistProductAdded(this.productId);

  final int productId;

  @override
  List<Object> get props => [productId];
}

final class WishlistProductRemoved extends WishlistEvent {
  const WishlistProductRemoved(this.productId);

  final int productId;

  @override
  List<Object> get props => [productId];
}
