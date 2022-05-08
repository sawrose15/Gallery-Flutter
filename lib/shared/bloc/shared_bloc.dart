import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'shared_event.dart';
part 'shared_state.dart';

@injectable
class SharedBloc extends Bloc<SharedEvent, SharedState> {
  SharedBloc() : super(SharedInitial()) {
    on<SharedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
