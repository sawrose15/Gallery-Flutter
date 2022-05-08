// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ServerFailure _$$_ServerFailureFromJson(Map<String, dynamic> json) =>
    _$_ServerFailure(
      message: json['message'] as String?,
      documentationUrl: json['documentationUrl'] as String?,
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ServerError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ServerFailureToJson(_$_ServerFailure instance) =>
    <String, dynamic>{
      'message': instance.message,
      'documentationUrl': instance.documentationUrl,
      'errors': instance.errors,
    };

_$_ServerError _$$_ServerErrorFromJson(Map<String, dynamic> json) =>
    _$_ServerError(
      code: json['code'] as String?,
      message: json['message'] as String?,
      field: json['field'] as String?,
      resource: json['resource'] as String?,
    );

Map<String, dynamic> _$$_ServerErrorToJson(_$_ServerError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'field': instance.field,
      'resource': instance.resource,
    };
