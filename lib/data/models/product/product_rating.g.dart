// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Rating _$RatingFromJson(Map<String, dynamic> json) => _Rating(
      rate: (json['rate'] as num).toDouble(),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$RatingToJson(_Rating instance) => <String, dynamic>{
      'rate': instance.rate,
      'count': instance.count,
    };
