import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';
import 'package:photo_repository/photo_repository.dart';

part 'photo_overview_event.dart';
part 'photo_overview_state.dart';

class PhotoOverviewBloc extends Bloc<PhotoOverviewEvent, PhotoOverviewState> {
  PhotoOverviewBloc({required PhotoRepository photoRepository})
      : _photoRepository = photoRepository,
        super(PhotoOverviewState()) {
    on<PhotoOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<PhotoOverviewFilterChanged>(_onFilterChanged);
  }

  final PhotoRepository _photoRepository;

  Future<void> _onSubscriptionRequested(
      PhotoOverviewSubscriptionRequested event,
      Emitter<PhotoOverviewState> emit) async {
    emit(state.copyWith(status: () => PhotoOverviewStatus.initial));

    await emit.forEach<List<Photo>>(
      _photoRepository.getPhotos(),
      onData: (photos) => state.copyWith(
        status: () => PhotoOverviewStatus.success,
        photos: () => photos,
      ),
      onError: (_, __) =>
          state.copyWith(status: () => PhotoOverviewStatus.failure),
    );
  }

  void _onFilterChanged(
      PhotoOverviewFilterChanged event, Emitter<PhotoOverviewState> emit) {
    emit(state.copyWith(filter: () => event.filter));
  }
}
