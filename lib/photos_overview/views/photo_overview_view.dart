import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_detail/photo_detail.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';
import 'package:photo_gallery/photos_overview/widgets/bottom_loader.dart';

class PhotoOverviewView extends StatefulWidget {
  const PhotoOverviewView({Key? key}) : super(key: key);

  @override
  State<PhotoOverviewView> createState() => _PhotoOverviewViewState();
}

class _PhotoOverviewViewState extends State<PhotoOverviewView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery App'),
        actions: const <Widget>[
          PhotoOverviewGridButton(),
          PhotoOverviewFilterButton(),
          PhotoOverviewLogoutButton(),
        ],
      ),
      body: BlocBuilder<PhotoOverviewBloc, PhotoOverviewState>(
        builder: (context, state) {
          switch (state.status) {
            case PhotoOverviewStatus.failure:
              return const Center(
                child: Text('Failed to fetch data'),
              );
            case PhotoOverviewStatus.success:
              if (state.filteredPhoto.isEmpty) {
                return Center(
                  child: Text(
                    'Gallery is empty',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }
              return GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: state.gridSize,
                ),
                itemCount: state.hasReachedMax
                    ? state.photos.length
                    : state.photos.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.photos.length
                      ? const BottomLoader()
                      : PhotoOverviewImageList(
                          photo: state.photos[index],
                          onTap: () {
                            Navigator.of(context).push(
                              PhotoDetailPage.route(state.photos[index]),
                            );
                          },
                          onFavToggle: () {
                            context.read<PhotoOverviewBloc>().add(
                                  PhotoOverviewFavouriteToggle(
                                    photo: state.photos[index],
                                    isFav: state.photos[index].isFav
                                        ? false
                                        : true,
                                  ),
                                );
                          },
                        );
                },
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context
          .read<PhotoOverviewBloc>()
          .add(const PhotoOverviewSubscriptionRequested());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
