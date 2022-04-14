part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

extension HomeStatusX on HomeStatus {
  bool get isLoadingOrSuccess => [
    HomeStatus.loading,
    HomeStatus.success,
  ].contains(this);
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.initialPhoto,
    this.fileName = '',
    this.uploadedBy = '',
});

  final HomeStatus status;
  final Photo? initialPhoto;
  final String? fileName;
  final String? uploadedBy;

  bool get isNewPhoto => initialPhoto == null;

  HomeState copyWith({
  HomeStatus? status,
    Photo? initialPhoto,
    String? fileName,
    String? uploadedBy,
}){
    return HomeState(
      status: status ?? this.status,
      initialPhoto: initialPhoto ?? this.initialPhoto,
      fileName: fileName ?? this.fileName,
      uploadedBy: uploadedBy ?? this.uploadedBy,
    );
  }

  @override
  List<Object> get props => [status, initialPhoto, fileName, uploadedBy];
}
