import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'photo_detail_event.dart';
part 'photo_detail_state.dart';

class PhotoDetailBloc extends Bloc<PhotoDetailEvent, PhotoDetailState> {
  PhotoDetailBloc() : super(PhotoDetailInitial()) {
    on<PhotoDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
