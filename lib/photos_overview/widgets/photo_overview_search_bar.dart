import 'package:flutter/material.dart';

class PhotoOverviewSearchBar extends StatelessWidget {
  const PhotoOverviewSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: const TextField(
        key: Key('photo_overview_search_view'),
        decoration: InputDecoration(
          label: Text('Search'),
          labelStyle: TextStyle(color: Colors.white),
          icon: Icon(Icons.search),
        ),
      ),
    );
  }
}
