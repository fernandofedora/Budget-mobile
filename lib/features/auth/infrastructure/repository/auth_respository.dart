import 'package:injectable/injectable.dart';

import 'package:budget_mobile/features/auth/infrastructure/repository/i_auth_repository.dart';
import 'package:budget_mobile/features/auth/infrastructure/data_source/i_auth_data_source.dart';

@LazySingleton(as: IAuthRepository)
class AuthRespository implements IAuthRepository {
  final IAuthDataSource _authDataSource;

  const AuthRespository(this._authDataSource);

  @override
  Future<String> register({
    required String email,
    required String password,
  }) async {
    try {
      return await _authDataSource.register(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> login({required String email, required String password}) async {
    try {
      return await _authDataSource.login(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
}
