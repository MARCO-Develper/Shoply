import 'dart:convert';

class JwtHelper {
  static bool isTokenExpired(String token) {
    try {
      final payload = _decodePayload(token);
      final exp = payload['exp'];
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isAfter(expiryDate);
    } catch (_) {
      return true;
    }
  }

  static Map<String, dynamic> _decodePayload(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('Invalid token');

    final payload = base64Url.normalize(parts[1]);
    final payloadString = utf8.decode(base64Url.decode(payload));
    return json.decode(payloadString);
  }
}
