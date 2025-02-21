import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:budget_mobile/core/network/interceptors/network_interceptor.dart';

extension DioInterceptors on Dio {
  void addInterceptors() async {
    final loggerInterceptor = PrettyDioLogger();
    final networkInterceptor = NetworkInterceptor();

    interceptors.addAll([loggerInterceptor, networkInterceptor]);
  }
}
