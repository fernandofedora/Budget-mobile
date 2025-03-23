import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class SPService {
  final SharedPreferences _sp;

  final _tokenKey = 'TOKEN';

  SPService(this._sp);

  //* GET
  String? _getStoredString(String key) => _sp.getString(key);

  String getToken() => _getStoredString(_tokenKey) ?? '';

  //* SET
  Future<void> _saveString(String key, String value) async {
    await _sp.setString(key, value);
  }

  Future<void> saveToken(String token) async {
    await _saveString(_tokenKey, token);
  }

  //* REMOVE
  Future<void> _removeValue(String key) async {
    await _sp.remove(key);
  }

  Future<void> deleteToken() async => await _removeValue(_tokenKey);
}
