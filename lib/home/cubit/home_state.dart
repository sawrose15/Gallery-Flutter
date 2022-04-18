part of 'home_cubit.dart';

enum HomeTab { home, shared }

class HomeState extends Equatable {
  const HomeState._({
    required this.tab
  });

  final HomeTab tab;

  const HomeState.home():
        this._(tab: HomeTab.home);

  const HomeState.shared():
        this._(tab: HomeTab.shared);

  @override
  List<Object> get props => [tab];
}
