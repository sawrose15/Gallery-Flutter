part of 'photo_overview_bloc.dart';

enum PhotoOverviewStatus { initial, loading, success, failure }

class PhotoOverviewState extends Equatable {
  const PhotoOverviewState({
    this.status = PhotoOverviewStatus.initial,
    this.photos = const [],
    this.filter = PhotoViewFilter.oldest_latest,
  });

  final PhotoOverviewStatus status;
  final List<Photo> photos;
  final PhotoViewFilter filter;

  Iterable<Photo> get filteredPhoto => filter.applyAll(photos);

  PhotoOverviewState copyWith({
    PhotoOverviewStatus Function()? status,
    List<Photo> Function()? photos,
    PhotoViewFilter Function()? filter,
  }) {
    return PhotoOverviewState(
      status: status != null ? status() : this.status,
      photos: photos != null ? photos() : this.photos,
      filter: filter != null ? filter() : this.filter,
    );
  }

  @override
  List<Object?> get props => [
        status,
        photos,
        filter,
      ];
}
