import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_api/photo_api.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

part 'photo_overview_event.dart';
part 'photo_overview_state.dart';

@injectable
class PhotoOverviewBloc extends Bloc<PhotoOverviewEvent, PhotoOverviewState> {
  PhotoOverviewBloc({required PhotoApi photoApi})
      : _photoApi = photoApi,
        super(const PhotoOverviewState()) {
    on<PhotoOverviewUploadPhoto>(_onUploadPhoto);
    on<PhotoOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<PhotoOverviewFilterChanged>(_onFilterChanged);
    on<PhotoOverviewChangeGridLayout>(_onGridChanged);
    on<PhotoOverviewFavouriteToggle>(_onPhotoFavouriteToggle);
    on<PhotoOverviewDeletePhoto>(_onPhotoRemoveRequested);
  }

  final PhotoApi _photoApi;

  Future _onUploadPhoto(
    PhotoOverviewUploadPhoto event,
    Emitter<PhotoOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => PhotoOverviewStatus.loading));
    try {
      var imageSource = event.source;
      XFile? file = await ImagePicker().pickImage(source: imageSource);
      if (file != null) {
        Photo photo = Photo(
          filePath: file.path,
          uploadedBy: FirebaseAuth.instance.currentUser!.uid,
          uploadedDate: DateTime.now().toString(),
        );

        await _photoApi.savePhoto(File(file.path), photo);
        emit(state.copyWith(status: () => PhotoOverviewStatus.success));
      } else {
        emit(state.copyWith(
            status: () => PhotoOverviewStatus.failure,
            errorMessage: () => "Error while uploading"));
      }
    } catch (e) {
      emit(state.copyWith(status: () => PhotoOverviewStatus.failure));
    }
  }

  Future<void> _onSubscriptionRequested(
      PhotoOverviewSubscriptionRequested event,
      Emitter<PhotoOverviewState> emit) async {
    emit(state.copyWith(status: () => PhotoOverviewStatus.initial));

    await emit.forEach<List<Photo>>(
      _photoApi.getPhotos(),
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

  void _onGridChanged(
      PhotoOverviewChangeGridLayout event, Emitter<PhotoOverviewState> emit) {
    emit(state.copyWith(gridSize: () => event.gridSize == 3 ? 5 : 3));
  }

  Future<void> _onPhotoFavouriteToggle(PhotoOverviewFavouriteToggle event,
      Emitter<PhotoOverviewState> emit) async {
    final newPhoto = event.photo.copyWith(isFav: event.isFav);
    await _photoApi.addPhotoToFav(newPhoto);
  }

  Future<void> _onPhotoRemoveRequested(
      PhotoOverviewDeletePhoto event, Emitter<PhotoOverviewState> emit) async {
    emit(state.copyWith(status: () => PhotoOverviewStatus.loading));
    try {
      await _photoApi.deletePhoto(event.photo);
    } on PhotoNotFoundException {
      emit(state.copyWith(
          status: () => PhotoOverviewStatus.failure,
          errorMessage: () => "Error while deleting."));
    } catch (_) {
      emit(state.copyWith(
          status: () => PhotoOverviewStatus.failure,
          errorMessage: () => "Server Error"));
    }
  }
}
