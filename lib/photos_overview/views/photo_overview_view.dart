import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

class PhotoOverviewView extends StatelessWidget {
  const PhotoOverviewView({Key? key}) : super(key: key);

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
      body: BlocListener<PhotoOverviewBloc, PhotoOverviewState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == PhotoOverviewStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text("Error Retrieving Photos")),
              );
          }
        },
        child: BlocBuilder<PhotoOverviewBloc, PhotoOverviewState>(
          builder: (context, state) {
            if (state.photos.isEmpty) {
              if (state.status == PhotoOverviewStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != PhotoOverviewStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    "Gallery is empty",
                    style: Theme.of(context).textTheme.caption,
                  ),
                );
              }
            }

            return CupertinoScrollbar(
              child: Column(
                children: [
                  const PhotoOverviewSearchBar(),
                  CupertinoScrollbar(
                      child: PhotoOverviewGridLayout(
                          crossAxisCount: state.gridSize,
                          photos: state.filteredPhoto.toList())),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
