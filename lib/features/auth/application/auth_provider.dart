import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:budget_mobile/di/injection.dart';
import 'package:budget_mobile/core/shared/sp_service/sp_service.dart';
import 'package:budget_mobile/features/auth/infrastructure/repository/i_auth_repository.dart';

part 'auth_provider.g.dart';

@riverpod
Future<bool> register(Ref ref, String email, String password) async {
  final token = await locator<IAuthRepository>().register(email: email, password: password);

  if (token.isEmpty) {
    return false;
  }
  // Save token to shared preferences
  locator<SPService>().saveToken(token);
  return true;
}

@riverpod
Future<bool> login(Ref ref, String email, String password) async {
  final token = await locator<IAuthRepository>().login(email: email, password: password);

  if (token.isEmpty) {
    return false;
  }
  // Save token to shared preferences
  locator<SPService>().saveToken(token);
  return true;
}
