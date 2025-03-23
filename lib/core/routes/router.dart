import 'package:auto_route/auto_route.dart';

import 'package:budget_mobile/core/routes/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<CustomRoute> get routes => [
    CustomRoute(
      initial: true,
      path: '/signup',
      page: SignupRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      path: '/load',
      page: LoadRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
  ];
}
