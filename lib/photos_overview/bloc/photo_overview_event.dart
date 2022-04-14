part of 'photo_overview_bloc.dart';

abstract class PhotoOverviewEvent extends Equatable {
  const PhotoOverviewEvent();

  @override
  List<Object?> get props => [];
}

class PhotoOverviewSubscriptionRequested extends PhotoOverviewEvent{
  const PhotoOverviewSubscriptionRequested();
}

class PhotoOverviewFilterChanged extends PhotoOverviewEvent {
  const PhotoOverviewFilterChanged(this.filter);

  final PhotoViewFilter filter;

  @override
  List<Object?> get props => [filter];
}


