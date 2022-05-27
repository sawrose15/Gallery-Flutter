import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'photo_overview_list_event.dart';
part 'photo_overview_list_state.dart';

class PhotoOverviewListBloc extends Bloc<PhotoOverviewListEvent, PhotoOverviewListState> {
  PhotoOverviewListBloc() : super(PhotoOverviewListInitial()) {
    on<PhotoOverviewListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
