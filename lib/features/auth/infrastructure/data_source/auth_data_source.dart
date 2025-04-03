import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:budget_mobile/core/constants/url.dart';
import 'package:budget_mobile/features/auth/infrastructure/data_source/i_auth_data_source.dart';

@LazySingleton(as: IAuthDataSource)
class AuthDataSource implements IAuthDataSource {
  final Dio _client;

  const AuthDataSource(this._client);

  @override
  Future<String> register({required String email, required String password}) async {
    final response = await _client.post(registerUrl, data: {'email': email, 'password': password});

    if (response.statusCode == 201) {
      return response.data['token'];
    } else {
      return '';
    }
  }

  @override
  Future<String> login({required String email, required String password}) async {
    final response = await _client.post(loginUrl, data: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      return response.data['token'];
    } else {
      return '';
    }
  }
}
