abstract class IAuthDataSource {
  Future<String> register({required String email, required String password});
  Future<String> login({required String email, required String password});
}
