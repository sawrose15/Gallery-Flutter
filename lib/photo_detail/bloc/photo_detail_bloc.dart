import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_api/photo_api.dart';

part 'photo_detail_event.dart';
part 'photo_detail_state.dart';

@injectable
class PhotoDetailBloc extends Bloc<PhotoDetailEvent, PhotoDetailState> {
  PhotoDetailBloc({
    required PhotoApi photoApi,
  })  : _photoApi = photoApi,
        super(
          const PhotoDetailState(),
        ) {
    on<PhotoDetailEvent>((event, emit) {});
  }

  final PhotoApi _photoApi;
}
