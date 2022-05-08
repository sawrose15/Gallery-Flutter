import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_gallery/features/core/domain/entities/models.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState()) {
    on<AppEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
