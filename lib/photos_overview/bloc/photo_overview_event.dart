part of 'photo_overview_bloc.dart';

abstract class PhotoOverviewEvent extends Equatable {
  const PhotoOverviewEvent();

  @override
  List<Object?> get props => [];
}

class PhotoOverviewSubscriptionRequested extends PhotoOverviewEvent {
  const PhotoOverviewSubscriptionRequested();
}

class PhotoOverviewFilterChanged extends PhotoOverviewEvent {
  const PhotoOverviewFilterChanged(this.filter);

  final PhotoViewFilter filter;

  @override
  List<Object?> get props => [filter];
}

class PhotoOverviewChangeGridLayout extends PhotoOverviewEvent {
  final int gridSize;

  const PhotoOverviewChangeGridLayout({required this.gridSize});

  @override
  List<Object?> get props => [gridSize];
}

class PhotoOverviewUploadPhoto extends PhotoOverviewEvent {
  const PhotoOverviewUploadPhoto(this.source);

  final ImageSource source;

  @override
  List<Object?> get props => [source];
}

class PhotoOverviewFavouriteToggle extends PhotoOverviewEvent {
  final Photo photo;
  final bool isFav;

  const PhotoOverviewFavouriteToggle({
    required this.photo,
    required this.isFav,
  });

  @override
  List<Object?> get props => [photo, isFav];
}

class PhotoOverviewDeletePhoto extends PhotoOverviewEvent {
  final Photo photo;

  const PhotoOverviewDeletePhoto({required this.photo});

  @override
  List<Object?> get props => [photo];
}

class PhotoOverviewRenamePhoto extends PhotoOverviewEvent {
  final Photo photo;
  final String fileName;

  const PhotoOverviewRenamePhoto({required this.photo, required this.fileName});

  @override
  List<Object?> get props => [photo, fileName];
}
