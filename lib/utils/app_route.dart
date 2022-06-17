import 'package:auto_route/auto_route.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:photo_gallery/features/authentication/presentation/pages/login/login.dart';
import 'package:photo_gallery/features/authentication/presentation/pages/register/register.dart';
import 'package:photo_gallery/features/home/presentation/pages/home_page.dart';
import 'package:photo_gallery/features/photo_overview_list/presentation/pages/photo_overview_page.dart';
import 'package:photo_gallery/features/shared/presentation/pages/shared_page.dart';
import 'package:photo_gallery/utils/AuthGuard.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: LoginPage,
      path: '/login',
    ),
    AutoRoute(
      page: RegisterPage,
      path: '/register',
    ),
    AutoRoute(
      page: HomePage,
      initial: true,
      path: '/',
      guards: [AuthGuard],
      children: [
        AutoRoute(
          page: EmptyPageRoute,
          maintainState: true,
          name: 'photoFullRoute',
          path: 'photoFullRoute',
          children: [
            AutoRoute(
              page: PhotoOverviewPage,
              name: 'photoOverview',
              initial: true,
            ),
          ],
        ),
        AutoRoute(
          path: 'shared',
          name: 'SharedRoute',
          page: SharedPage,
        ),
      ],
    ),
  ],
)
class $AppRoute {}

class EmptyPageRoute extends AutoRouter {
  const EmptyPageRoute({Key? key}) : super(key: key);
}
