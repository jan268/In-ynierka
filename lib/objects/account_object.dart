import 'dart:convert';

import 'package:http/http.dart';
import 'package:net_market/utilities/user_secure_storage.dart';

class AccountObject {
  String? id;
  String? userId;
  String? firstName;
  String? lastName;
  String? sellerLevel;
  int? salesCompleted;
  String? paypalEmail;
  String? billingStreet;
  String? billingAddressLine1;
  String? billingAddressLine2;
  String? billingZipCode;
  String? billingCountry;
  String? shippingStreet;
  String? shippingAddressLine1;
  String? shippingAddressLine2;
  String? shippingZipCode;
  String? shippingCountry;

  AccountObject({this.id, this.userId, this.firstName, this.lastName,
    this.sellerLevel, this.salesCompleted, this.paypalEmail,
    this.billingStreet, this.billingAddressLine1, this.billingAddressLine2,
    this.billingZipCode, this.billingCountry, this.shippingStreet,
    this.shippingAddressLine1, this.shippingAddressLine2,
    this.shippingZipCode, this.shippingCountry});

  factory AccountObject.fromJson(Map<String, dynamic> json) {
    return AccountObject(
      id: json["id"],
      userId: json["userId"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      sellerLevel: json["sellerLevel"],
      salesCompleted: json["salesCompleted"],
      paypalEmail: json["paypalEmail"],
      billingStreet: json["billingStreet"],
      billingAddressLine1: json["billingAddressLine1"],
      billingAddressLine2: json["billingAddressLine2"],
      billingZipCode: json["billingZipCode"],
      billingCountry: json["billingCountry"],
      shippingStreet: json["shippingStreet"],
      shippingAddressLine1: json["shippingAddressLine1"],
      shippingAddressLine2: json["shippingAddressLine2"],
      shippingZipCode: json["shippingZipCode"],
      shippingCountry: json["shippingCountry"],
    );
  }

  static Future<AccountObject> getAccount() async {
    String? token = await UserSecureStorage.getJwt();
    print(token);
    String jwt =  "Bearer " + token!.substring(token.lastIndexOf(':') + 2, token.length-2);
    // make request
    Response response = await get(Uri.parse("http://netmarket-api.eu-central-1.elasticbeanstalk.com/api/user"),
        headers: {
          "Authorization": jwt,
          "accept": "*/*",
          "Content-Type": "application/json"
        });
    var json = jsonDecode(response.body);
    return AccountObject.fromJson(json);
  }
}