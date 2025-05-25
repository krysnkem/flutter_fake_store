import 'package:equatable/equatable.dart';

sealed class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

final class WishlistInitial extends WishlistState {
  
}

final class WishlistLoading extends WishlistState {}

final class WishlistLoaded extends WishlistState {
  final Set<int> productIds;

  const WishlistLoaded({required this.productIds});

  @override
  List<Object> get props => [productIds];
}

final class WishlistError extends WishlistState {
  final String message;
  const WishlistError({required this.message});

  @override
  List<Object> get props => [message];
}

final class WislistUpdateError extends WishlistError {
  final Set<int> productIds;
  const WislistUpdateError({required super.message, required this.productIds});
}
