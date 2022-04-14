import 'dart:async';
import 'dart:html';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_repository/photo_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required AuthenticationRepository authenticationRepository,
    required PhotoRepository photoRepository,
    required Photo initialPhoto,
}) : _authenticationRepository = authenticationRepository,
  _photoRepository = photoRepository,
        super(HomeState(
        initialPhoto: initialPhoto,
        fileName: initialPhoto?.fileName ?? '',
        uploadedBy:  '',
      )) {
    on<HomePhotoSubmitted>(_onPhotoSubmitted);
  }

  final PhotoRepository _photoRepository;
  final AuthenticationRepository _authenticationRepository;

  Future<void> _onPhotoSubmitted(
      HomePhotoSubmitted event,
      Emitter<HomeState> emit
      )async {
    emit(state.copyWith(status: HomeStatus.loading));
    final photo = (state.initialPhoto ?? const Photo(uploadedBy: '')).copyWith(
      fileName: state.fileName,
      uploadedBy: _authenticationRepository.currentUser.email,
      uploadedDate: DateTime.now().toString(),
    );

    try{
      await _photoRepository.savePhoto(photo);
      emit(state.copyWith(status: HomeStatus.success));
    }catch(e){
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}
