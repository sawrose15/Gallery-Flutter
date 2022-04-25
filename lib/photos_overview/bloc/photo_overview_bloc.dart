import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_photo_api/firebase_photo_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_api/photo_api.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

part 'photo_overview_event.dart';

part 'photo_overview_state.dart';

class PhotoOverviewBloc extends Bloc<PhotoOverviewEvent, PhotoOverviewState> {
  PhotoOverviewBloc({
    required FirebasePhotoApi firebasePhotoApi
  }):_firebasePhotoApi = firebasePhotoApi,
        super(const PhotoOverviewState()) {
    on<PhotoOverviewUploadPhoto>(_onUploadPhoto);
    on<PhotoOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<PhotoOverviewFilterChanged>(_onFilterChanged);
    on<PhotoOverviewChangeGridLayout>(_onGridChanged);
    on<PhotoOverviewFavouriteToggle>(_onPhotoFavouriteToggle);
  }

  final FirebasePhotoApi _firebasePhotoApi;

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

  void _onGridChanged(
      PhotoOverviewChangeGridLayout event,
      Emitter<PhotoOverviewState> emit
      ){
    emit(state.copyWith(status:() => PhotoOverviewStatus.loading));
  }


  Future<void> _onPhotoFavouriteToggle(
      PhotoOverviewFavouriteToggle event,
      Emitter<PhotoOverviewState> emit
      ) async{
    final currentUserId = FirebaseAuth.instance.currentUser!.uid.toString();
    final newPhoto = event.photo.copyWith(isFav: event.isFav);
    await _firebasePhotoApi.addPhotoToFav(currentUserId, newPhoto);
  }
}
