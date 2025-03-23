import 'package:dio/dio.dart';

import 'package:budget_mobile/di/injection.dart';
import 'package:budget_mobile/core/shared/sp_service/sp_service.dart';

class NetworkInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = locator<SPService>().getToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
