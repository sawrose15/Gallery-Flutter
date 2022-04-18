import 'package:flutter/material.dart';
import 'package:photo_gallery/home/home.dart';
import 'package:photo_gallery/photos_overview/photo_overview.dart';

List<Page> onGenerateHomeViewPages(HomeTab status, List<Page<dynamic>> pages) {
  switch (status) {
    case HomeTab.home:
      return [PhotoOverviewPage.page()];
    case HomeTab.shared:
      return [PhotoOverviewPage.page()];
  }
}