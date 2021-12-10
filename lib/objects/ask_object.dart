import 'dart:convert';

import 'package:http/http.dart';
import 'package:net_market/objects/item_object.dart';
import 'package:net_market/objects/size_object.dart';
import 'package:net_market/utilities/user_secure_storage.dart';

class AskObject {
  String? id;
  ItemObject? item;
  SizeObject? size;
  String? price;
  String? userId;
  String? expires;
  String? sellerFee;

  AskObject(
      {this.id,
      this.item,
      this.size,
      this.price,
      this.userId,
      this.expires,
      this.sellerFee
      });

  AskObject.name(this.id, this.item, this.size, this.price, this.userId,
      this.expires, this.sellerFee);

  factory AskObject.fromJson(Map<String, dynamic> json) {
    return AskObject(
        id: json["id"],
        item: ItemObject.fromJson(json["item"]),
        size: SizeObject.fromJson(json["size"]),
        price: json["price"],
        userId: json["userId"],
        expires: json["expires"],
        sellerFee: json["sellerFee"]
    );
  }

  static Future<List<AskObject>> getAsks() async {
    // make request
    String? token = await UserSecureStorage.getJwt();
    String jwt =  "Bearer " + token!.substring(token.lastIndexOf(':') + 2, token.length-2);
    List<AskObject> items;
    Response response = await get(Uri.parse("http://netmarket-api.eu-central-1.elasticbeanstalk.com/api/Asks?PageSize=10"),
        headers: {
          "Authorization": jwt,
          "accept": "*/*",
          "Content-Type": "application/json"
        });
    var data = jsonDecode(response.body);
    var list = data["items"] as List;
    items = list.map<AskObject>((json) => AskObject.fromJson(json)).toList();

    return items;
  }
}