import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_photo_api/firebase_photo_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_api/photo_api.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

part 'photo_overview_event.dart';
part 'photo_overview_state.dart';

@injectable
class PhotoOverviewBloc extends Bloc<PhotoOverviewEvent, PhotoOverviewState> {
  PhotoOverviewBloc({
    required AuthenticationRepository authenticationRepository,
    required PhotoApi photoApi,
  })  : _photoApi = photoApi,
        _authenticationRepository = authenticationRepository,
        super(const PhotoOverviewState(gridSize: 3)) {
    on<PhotoOverviewUploadPhoto>(_onUploadPhoto);
    on<PhotoOverviewSubscriptionRequested>(_onSubscriptionRequested);
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
      final file =
          await ImagePicker().pickImage(source: imageSource, imageQuality: 50);
      if (file != null) {
        final photo = Photo(
          filePath: file.path,
          uploadedBy: FirebaseAuth.instance.currentUser!.uid,
          uploadedDate: DateTime.now().toString(),
        );

        await _photoApi.savePhoto(File(file.path), photo);
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
    emit(state.copyWith(status: () => PhotoOverviewStatus.initial));

    await emit.forEach<List<Photo>>(
      _photoApi.getPhotos(_authenticationRepository.currentUser.id!),
      onData: (photos) => state.copyWith(
        status: () => PhotoOverviewStatus.success,
        photos: () => photos,
      ),
      onError: (_, __) =>
          state.copyWith(status: () => PhotoOverviewStatus.failure),
    );
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
