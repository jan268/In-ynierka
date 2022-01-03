import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:net_market/utilities/user_secure_storage.dart';

class DecodedTokenObject {
  String? username;
  String? role;
  String? email;
  String? id;
  bool? isExpired;


  DecodedTokenObject(
      {this.username, this.role, this.email, this.id, this.isExpired});

  static Future<DecodedTokenObject> getDecodedToken() async {
    String? token = await UserSecureStorage.getJwt();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    return DecodedTokenObject(
        username: decodedToken['username'],
        role: decodedToken['role'],
        email: decodedToken['email'],
        id: decodedToken['id'],
        isExpired: JwtDecoder.isExpired(token)
    );
  }
}