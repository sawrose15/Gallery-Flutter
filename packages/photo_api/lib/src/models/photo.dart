import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:photo_api/photo_api.dart';
import 'package:uuid/uuid.dart';

part 'photo.g.dart';

@Immutable()
@JsonSerializable()
class Photo extends Equatable {

  ///{@macro Photo}
  const Photo({
    this.id = '',
    this.fileName,
    @required this.uploadedBy,
    this.uploadedDate,
  });

  final String? id;
  final String? fileName;
  final String? uploadedBy;
  final String? uploadedDate;

  Photo copyWith({
    String? id,
    String? fileName,
    String? uploadedBy,
    String? uploadedDate,
  }) {
    return Photo(
        id: id ?? this.id,
        fileName: fileName ?? this.fileName,
        uploadedBy: uploadedBy ?? this.uploadedBy,
        uploadedDate: uploadedDate ?? this.uploadedDate
    );
  }

  factory Photo.fromJson(JsonMap photo) =>
      _$PhotoFromJson(photo);

  JsonMap toJson() => _$PhotoToJson(this);

  @override
  List<Object?> get props => [id, fileName, uploadedBy, uploadedDate];
}