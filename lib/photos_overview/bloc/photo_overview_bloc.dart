import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_photo_api/firebase_photo_api.dart';
import 'package:photo_api/photo_api.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

part 'photo_overview_event.dart';

part 'photo_overview_state.dart';

class PhotoOverviewBloc extends Bloc<PhotoOverviewEvent, PhotoOverviewState> {
  PhotoOverviewBloc({
    required FirebasePhotoApi firebasePhotoApi
  }):_firebasePhotoApi = firebasePhotoApi,
        super(const PhotoOverviewState()) {
    on<PhotoOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<PhotoOverviewFilterChanged>(_onFilterChanged);
    on<PhotoOverviewUploadPhoto>(_onUploadPhoto);
  }

  final FirebasePhotoApi _firebasePhotoApi;

  Future<void> _onSubscriptionRequested(
      PhotoOverviewSubscriptionRequested event,
      Emitter<PhotoOverviewState> emit) async {
    emit(state.copyWith(status: () => PhotoOverviewStatus.initial));

    await emit.forEach<List<Photo>>(
      _firebasePhotoApi.getPhotos(),
      onData: (photos) => state.copyWith(
        status: () => PhotoOverviewStatus.success,
        photos: () => photos,
      ),
      onError: (_, __) =>
          state.copyWith(status: () => PhotoOverviewStatus.failure),
    );
  }

  void _onFilterChanged(PhotoOverviewFilterChanged event,
      Emitter<PhotoOverviewState> emit) {
    emit(state.copyWith(filter: () => event.filter));
  }

  Future<void> _onUploadPhoto(PhotoOverviewUploadPhoto event,
      Emitter<PhotoOverviewState> emit,) async {
    emit(state.copyWith(status: () => PhotoOverviewStatus.loading));

    final file = File(event.filePath);
    Photo photo = Photo(
        filePath: file.path,
        uploadedBy: event.userId,
        uploadedDate: DateTime.now().toString(),
    );

    try {
      await _firebasePhotoApi.savePhoto(file, photo);
      emit(state.copyWith(status: () => PhotoOverviewStatus.success));
    }
    catch (e) {
      emit(state.copyWith(status: () => PhotoOverviewStatus.failure));
    }
  }
}
