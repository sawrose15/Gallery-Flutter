import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_api/photo_api.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';
import 'package:stream_transform/stream_transform.dart';

part 'photo_overview_event.dart';
part 'photo_overview_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

@injectable
class PhotoOverviewBloc extends Bloc<PhotoOverviewEvent, PhotoOverviewState> {
  PhotoOverviewBloc({
    required AuthenticationRepository authenticationRepository,
    required PhotoApi photoApi,
  })  : _photoApi = photoApi,
        _authenticationRepository = authenticationRepository,
        super(const PhotoOverviewState(gridSize: 3)) {
    on<PhotoOverviewUploadPhoto>(_onUploadPhoto);
    on<PhotoOverviewSubscriptionRequested>(
      _onSubscriptionRequested,
      transformer: throttleDroppable(throttleDuration),
    );
    on<PhotoOverviewFilterChanged>(_onFilterChanged);
    on<PhotoOverviewChangeGridLayout>(_onGridChanged);
    on<PhotoOverviewFavouriteToggle>(_onPhotoFavouriteToggle);
    on<PhotoOverviewDeletePhoto>(_onPhotoRemoveRequested);
    on<PhotoOverviewRenamePhoto>(_onPhotoRenameRequested);
  }

  final PhotoApi _photoApi;
  final AuthenticationRepository _authenticationRepository;

  Future _onUploadPhoto(
    PhotoOverviewUploadPhoto event,
    Emitter<PhotoOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => PhotoOverviewStatus.loading));
    try {
      final imageSource = event.source;
      final file = await ImagePicker().pickImage(
        source: imageSource,
      );
      if (file != null) {
        final imageFile = File(file.path);
        final image = await FlutterNativeImage.compressImage(
          imageFile.path,
          quality: 100,
          percentage: 30,
        );
        final photo = Photo(
          filePath: image.path,
          uploadedBy: FirebaseAuth.instance.currentUser!.uid,
          uploadedDate: DateTime.now().toString(),
        );

        await _photoApi.savePhoto(File(image.path), photo);
        emit(state.copyWith(status: () => PhotoOverviewStatus.success));
      } else {
        emit(
          state.copyWith(
            status: () => PhotoOverviewStatus.failure,
            errorMessage: () => 'Error while uploading',
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: () => PhotoOverviewStatus.failure));
    }
  }

  Future<void> _onSubscriptionRequested(
    PhotoOverviewSubscriptionRequested event,
    Emitter<PhotoOverviewState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PhotoOverviewStatus.initial) {
        final photos = await _photoApi
            .getPhotos(userId: _authenticationRepository.currentUser.id!)
            .first;
        return emit(
          state.copyWith(
            status: () => PhotoOverviewStatus.success,
            photos: () => photos,
            hasReachedMax: false,
          ),
        );
      }
      final photos = await _photoApi
          .getPhotos(
            userId: _authenticationRepository.currentUser.id!,
            startAfterId: state.photos.last.id,
          )
          .first;
      photos.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: () => PhotoOverviewStatus.success,
                photos: () => List.of(state.photos)..addAll(photos),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: () => PhotoOverviewStatus.failure));
    }
  }

  void _onFilterChanged(
    PhotoOverviewFilterChanged event,
    Emitter<PhotoOverviewState> emit,
  ) {
    emit(state.copyWith(filter: () => event.filter));
  }

  void _onGridChanged(
    PhotoOverviewChangeGridLayout event,
    Emitter<PhotoOverviewState> emit,
  ) {
    emit(state.copyWith(gridSize: () => event.gridSize));
  }

  Future<void> _onPhotoFavouriteToggle(
    PhotoOverviewFavouriteToggle event,
    Emitter<PhotoOverviewState> emit,
  ) async {
    final newPhoto = event.photo.copyWith(isFav: event.isFav);
    await _photoApi.addPhotoToFav(newPhoto);
  }

  Future<void> _onPhotoRemoveRequested(
    PhotoOverviewDeletePhoto event,
    Emitter<PhotoOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => PhotoOverviewStatus.loading));
    try {
      await _photoApi.deletePhoto(event.photo);
    } on PhotoNotFoundException {
      emit(
        state.copyWith(
          status: () => PhotoOverviewStatus.failure,
          errorMessage: () => 'Error while deleting.',
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: () => PhotoOverviewStatus.failure,
          errorMessage: () => 'Server Error',
        ),
      );
    }
  }

  Future<void> _onPhotoRenameRequested(
    PhotoOverviewRenamePhoto event,
    Emitter<PhotoOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => PhotoOverviewStatus.loading));
    final photo = event.photo.copyWith(fileName: event.fileName);
    try {
      await _photoApi.updatePhoto(photo);
      emit(state.copyWith(status: () => PhotoOverviewStatus.success));
    } catch (_) {
      emit(
        state.copyWith(
          status: () => PhotoOverviewStatus.failure,
          errorMessage: () => 'Server Error',
        ),
      );
    }
  }
}
