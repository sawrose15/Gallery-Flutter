// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      fileName: json['fileName'] as String?,
      uploadedBy: json['uploadedBy'] as String,
      uploadedDate: json['uploadedDate'] as String? ?? '',
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'fileName': instance.fileName,
      'uploadedBy': instance.uploadedBy,
      'uploadedDate': instance.uploadedDate,
    };
