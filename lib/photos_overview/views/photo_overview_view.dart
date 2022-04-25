import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

// class PhotoOverviewView extends StatelessWidget {
//   const PhotoOverviewView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Gallery App"),
//         actions: const <Widget>[
//           PhotoOverviewGridButton(),
//           PhotoOverviewFilterButton(),
//           PhotoOverviewLogoutButton(),
//         ],
//       ),
//       body: BlocListener<PhotoOverviewBloc, PhotoOverviewState>(
//         listenWhen: (previous, current) => previous.status != current.status,
//         listener: (context, state) {
//           if (state.status == PhotoOverviewStatus.failure) {
//             ScaffoldMessenger.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(
//                 const SnackBar(content: Text("Error Retrieving Photos")),
//               );
//           }
//         },
//         child: BlocBuilder<PhotoOverviewBloc, PhotoOverviewState>(
//           builder: (context, state) {
//             if (state.photos.isEmpty) {
//               if (state.status == PhotoOverviewStatus.loading) {
//                 return const Center(child: CupertinoActivityIndicator());
//               } else if (state.status == PhotoOverviewStatus.success) {
//                 return const SizedBox();
//               } else {
//                 return Center(
//                   child: Text(
//                     "Gallery is empty",
//                     style: Theme.of(context).textTheme.caption,
//                   ),
//                 );
//               }
//             }
//
//             return CupertinoScrollbar(
//               child:
//                   // PhotoOverviewGridLayout(photos: state.filteredPhoto)
//                   GridView.count(
//                       crossAxisCount: 2,
//                       padding: const EdgeInsets.all(8),
//                       mainAxisSpacing: 20.0,
//                       crossAxisSpacing: 20.0,
//                       children: [
//                     for (final photo in state.filteredPhoto)
//                       Image.network(photo.filePath)
//                   ]),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class PhotoOverviewView extends StatefulWidget {
  const PhotoOverviewView({Key? key}) : super(key: key);

  @override
  _PhotoOverviewViewState createState() => _PhotoOverviewViewState();
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
          title: const Text("Gallery App"),
          actions: const <Widget>[
            PhotoOverviewGridButton(),
            PhotoOverviewFilterButton(),
            PhotoOverviewLogoutButton(),
          ],
        ),
        body: BlocBuilder<PhotoOverviewBloc, PhotoOverviewState>(
          builder: (context, state) {
            if (state.photos.isEmpty) {
              if (state.status == PhotoOverviewStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != PhotoOverviewStatus.success) {
                return const SizedBox();
              } else {
                return const Center(
                  child: Text(
                    "Gallery is empty",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                );
              }
            }

            return CupertinoScrollbar(
                child: PhotoOverviewGridLayout(
                    crossAxisCount: 3, photos: state.filteredPhoto.toList()));
          },
        ));
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
