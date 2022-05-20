part of 'photo_detail_bloc.dart';

enum PhotoDetailStatus { initial, loading, sucess, failure }

class PhotoDetailState extends Equatable {
  const PhotoDetailState({
    this.status = PhotoDetailStatus.initial,
    this.initialPhoto,
  });

  final PhotoDetailStatus status;
  final Photo? initialPhoto;

  bool get isNewPhoto => initialPhoto == null;

  PhotoDetailState copyWith({
    PhotoDetailStatus? status,
    Photo? initialPhoto,
  }) {
    return PhotoDetailState(
      status: status ?? this.status,
      initialPhoto: initialPhoto ?? this.initialPhoto,
    );
  }

  @override
  List<Object?> get props => [status, initialPhoto];
}
