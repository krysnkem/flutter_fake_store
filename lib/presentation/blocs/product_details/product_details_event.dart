import 'package:equatable/equatable.dart';

final class GetProductDetailsEvent extends Equatable {
  final int id;
  const GetProductDetailsEvent(this.id);
  @override
  List<Object> get props => [id];
}
