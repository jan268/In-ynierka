import 'dart:convert';

import 'package:http/http.dart';
import 'package:net_market/objects/item_object.dart';
import 'package:net_market/objects/size_object.dart';
import 'package:net_market/utilities/user_secure_storage.dart';

class BidObject {
  String? id;
  ItemObject? item;
  SizeObject? size;
  String? price;
  String? userId;
  String? expires;
  String? buyerFee;


  BidObject(
      {this.id,
      this.item,
      this.size,
      this.price,
      this.userId,
      this.expires,
      this.buyerFee});

  BidObject.name(this.id, this.item, this.size, this.price, this.userId,
      this.expires, this.buyerFee);

  factory BidObject.fromJson(Map<String, dynamic> json) {
    return BidObject(
        id: json["id"],
        item: ItemObject.fromJson(json["item"]),
        size: SizeObject.fromJson(json["size"]),
        price: json["price"],
        userId: json["userId"],
        expires: json["expires"],
        buyerFee: json["buyerFee"]
    );
  }

  static Future<List<BidObject>> getAsks() async {
    // make request
    String? token = await UserSecureStorage.getJwt();
    String jwt =  "Bearer " + token!.substring(token.lastIndexOf(':') + 2, token.length-2);
    List<BidObject> items;
    Response response = await get(Uri.parse("http://netmarket-api.eu-central-1.elasticbeanstalk.com/api/Bids?PageSize=10"),
        headers: {
          "Authorization": jwt,
          "accept": "*/*",
          "Content-Type": "application/json"
        });
    var data = jsonDecode(response.body);
    var list = data["items"] as List;
    items = list.map<BidObject>((json) => BidObject.fromJson(json)).toList();

    return items;
  }
}