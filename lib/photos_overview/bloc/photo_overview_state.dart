part of 'photo_overview_bloc.dart';

enum PhotoOverviewStatus { initial, loading, success, failure }

class PhotoOverviewState extends Equatable {
  const PhotoOverviewState({
    this.status = PhotoOverviewStatus.initial,
    this.photos = const [],
    this.filter = PhotoViewFilter.oldest_latest,
    this.initialPhoto,
    this.gridSize = 3,
    this.errorMessage,
  }) : assert(gridSize == 3 || gridSize == 5);

  final PhotoOverviewStatus status;
  final List<Photo> photos;
  final PhotoViewFilter filter;
  final Photo? initialPhoto;
  final int gridSize;
  final String? errorMessage;

  Iterable<Photo> get filteredPhoto => filter.apply(photos);

  PhotoOverviewState copyWith({
    PhotoOverviewStatus Function()? status,
    List<Photo> Function()? photos,
    PhotoViewFilter Function()? filter,
    Photo Function()? initialPhoto,
    int Function()? gridSize,
    String Function()? errorMessage,
  }) {
    return PhotoOverviewState(
      status: status != null ? status() : this.status,
      photos: photos != null ? photos() : this.photos,
      filter: filter != null ? filter() : this.filter,
      initialPhoto: initialPhoto != null ? initialPhoto() : this.initialPhoto,
      gridSize: gridSize != null ? gridSize() : this.gridSize,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, photos, filter, initialPhoto, gridSize, errorMessage];
}
