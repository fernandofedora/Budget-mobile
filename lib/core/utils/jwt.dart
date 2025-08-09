import 'package:jwt_decoder/jwt_decoder.dart';

class JwtUtils {
  static Map<String, dynamic> _decodeJwt(String token) {
    return JwtDecoder.decode(token);
  }

  static bool isExpired(String token) {
    if (token.isEmpty) return true;
    final expValue = _decodeJwt(token)['exp'];
    return expValue != null ? JwtDecoder.isExpired(token) : false;
  }
}
