import 'package:flutter/material.dart';
import 'package:photo_gallery/app/app.dart';
import 'package:photo_gallery/home/home.dart';
import 'package:photo_gallery/login/login.dart';

List<Page> onGenerateAppViewPages(AppStatus status, List<Page<dynamic>> pages) {
  switch (status) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
