import 'package:auto_route/auto_route.dart';

import 'package:budget_mobile/di/injection.dart';
import 'package:budget_mobile/core/utils/jwt.dart';
import 'package:budget_mobile/core/routes/router.gr.dart';
import 'package:budget_mobile/core/shared/sp_service/sp_service.dart';

class CheckIfUserIsAuthenticated extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    var token = locator<SPService>().getToken();
    var isTokenExpired = JwtUtils.isExpired(token);

    if (!isTokenExpired) {
      resolver.next(true);
    } else {
      router.pushAndPopUntil(const LoginRoute(), predicate: (_) => false);
    }
  }
}
