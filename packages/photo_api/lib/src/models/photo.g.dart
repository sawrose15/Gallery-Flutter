// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      id: json['id'] as String?,
      fileName: json['fileName'] as String? ?? '',
      filePath: json['filePath'] as String,
      uploadedBy: json['uploadedBy'] as String,
      uploadedDate: json['uploadedDate'] as String? ?? '',
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'filePath': instance.filePath,
      'uploadedBy': instance.uploadedBy,
      'uploadedDate': instance.uploadedDate,
    };
