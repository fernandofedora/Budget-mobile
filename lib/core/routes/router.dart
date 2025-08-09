import 'package:auto_route/auto_route.dart';

import 'package:budget_mobile/core/routes/router.gr.dart';
import 'package:budget_mobile/core/routes/guards/auth_guard.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<CustomRoute> get routes => [
    CustomRoute(
      path: '/login',
      page: LoginRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      path: '/signup',
      page: SignupRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      initial: true,
      path: '/home',
      page: HomeRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      guards: [CheckIfUserIsAuthenticated()],
    ),
    // TODO: move this to a dialog form
    CustomRoute(
      path: '/edit-expense',
      page: EditExpenseRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
  ];
}
