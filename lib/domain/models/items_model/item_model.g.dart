// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      json['id'] as int,
      json['context'] as String,
      json['start_date'] as String?,
      json['end_date'] as String?,
      json['created_at'] as String,
      json['category'] as int,
      json['alert'] as String?,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'context': instance.context,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'created_at': instance.createdAt,
      'category': instance.category,
      'alert': instance.alert,
    };
