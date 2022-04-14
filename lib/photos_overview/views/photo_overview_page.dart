import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';
import 'package:photo_repository/photo_repository.dart';

class PhotoOverviewPage extends StatelessWidget {
  const PhotoOverviewPage({
    Key? key,
    required PhotoRepository photoRepository,
  }) : _photoRepository = photoRepository,
        super(key: key);

  final PhotoRepository _photoRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _photoRepository,
      child: BlocProvider(
        create: (_)=> PhotoOverviewBloc(
            photoRepository: _photoRepository
        ),
        child: const PhotoOverviewView(),
      ),
    );
  }
}

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
      body: MultiBlocListener(
        listeners: [
          BlocListener<PhotoOverviewBloc, PhotoOverviewState>(
            listenWhen: (previous, current) => previous.status !=current.status,
            listener: (context, state) {
              if(state.status == PhotoOverviewStatus.failure){
                ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text("Error Retrieving Photos")),
                    );
              }
            },
          ),
        ],
        child: BlocBuilder<PhotoOverviewBloc, PhotoOverviewState>(
          builder: (context, state) {
            if(state.photos.isEmpty){
              if(state.status == PhotoOverviewStatus.loading){
                  return const Center(child: CupertinoActivityIndicator());
              }else if(state.status == PhotoOverviewStatus.success){
                return const SizedBox();
              }else {
                return Center(
                  child: Text(
                    'Cannot find any photos',
                    style: Theme.of(context).textTheme.caption,
                  ),
                );
              }
            }

            return CupertinoScrollbar(
              child: ListView(
                children: [
                  Container()
                //   for (final photo in state.filteredPhoto)
                //
                ],
              ),
            );
          },
        ),

      ),
    );
  }
}

