import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:budget_mobile/core/network/interceptors/network_interceptor.dart';

extension DioInterceptors on Dio {
  void addInterceptors() async {
    if (kDebugMode) {
      interceptors.add(PrettyDioLogger(responseBody: true, compact: true));
    }
    interceptors.add(NetworkInterceptor());
  }
}
