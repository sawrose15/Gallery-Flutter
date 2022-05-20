part of 'photo_overview_bloc.dart';

enum PhotoOverviewStatus { initial, loading, success, failure }

class PhotoOverviewState extends Equatable {
  const PhotoOverviewState({
    this.status = PhotoOverviewStatus.initial,
    this.photos = const <Photo>[],
    this.selectedPhoto,
    this.filter = PhotoViewFilter.oldest_latest,
    this.gridSize = 0,
    this.hasReachedMax = false,
    this.errorMessage,
  }) : assert(gridSize == 3 || gridSize == 5);

  final PhotoOverviewStatus status;
  final List<Photo> photos;
  final Photo? selectedPhoto;
  final PhotoViewFilter filter;
  final int gridSize;
  final bool hasReachedMax;
  final String? errorMessage;

  Iterable<Photo> get filteredPhoto => filter.apply(photos);

  PhotoOverviewState copyWith({
    PhotoOverviewStatus Function()? status,
    List<Photo> Function()? photos,
    Photo Function()? selectedPhoto,
    PhotoViewFilter Function()? filter,
    int Function()? gridSize,
    bool? hasReachedMax,
    String Function()? errorMessage,
  }) {
    return PhotoOverviewState(
      status: status != null ? status() : this.status,
      photos: photos != null ? photos() : this.photos,
      selectedPhoto:
          selectedPhoto != null ? selectedPhoto() : this.selectedPhoto,
      filter: filter != null ? filter() : this.filter,
      gridSize: gridSize != null ? gridSize() : this.gridSize,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  String toString() {
    return '''PhotoState { status: $status, hasReachedMax: $hasReachedMax, photos: ${photos.length} }''';
  }

  @override
  List<Object?> get props => [
        status,
        photos,
        selectedPhoto,
        filter,
        gridSize,
        hasReachedMax,
        errorMessage
      ];
}
