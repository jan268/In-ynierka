
import 'dart:convert';

import 'package:http/http.dart';
import 'package:net_market/objects/filter_object.dart';

import 'brand_object.dart';

class ItemObject {

  String? id;
  String? name;
  String? category;
  String? model;
  String? gender;
  double? retailPrice;
  String? description;
  String? imageUrl;
  String? smallImageUrl;
  String? thumbUrl;
  BrandObject? brand;
  String? lowestAsk;
  String? highestBid;

  ItemObject({
      this.id,
      this.name,
      this.category,
      this.model,
      this.gender,
      this.retailPrice,
      this.description,
      this.imageUrl,
      this.smallImageUrl,
      this.thumbUrl,
      this.lowestAsk,
      this.highestBid
  });

  ItemObject.item(
      this.id,
      this.name,
      this.category,
      this.model,
      this.gender,
      this.retailPrice,
      this.description,
      this.imageUrl,
      this.smallImageUrl,
      this.thumbUrl);

  ItemObject.name(
      this.id,
      this.name,
      this.category,
      this.model,
      this.gender,
      this.retailPrice,
      this.description,
      this.imageUrl,
      this.smallImageUrl,
      this.thumbUrl,
      this.brand);

  static Future<List<ItemObject>> getItemsFromCategory(String category) async {
    // make request
    List<ItemObject> items;
    Response response = await get(Uri.parse("http://netmarket-api.eu-central-1.elasticbeanstalk.com/api/Items?Category=${category}"));
    var data = jsonDecode(response.body);
    var list = data["items"] as List;
    items = list.map<ItemObject>((json) => ItemObject.fromJson(json)).toList();

    return items;
  }

  static Future<List<ItemObject>> getItemsWithFilters(FilterObject filterObject) async {
    // make request
    List<ItemObject> items;
    Response response = await get(Uri.parse("http://netmarket-api.eu-central-1.elasticbeanstalk.com/api/Items?Brand=${filterObject.brand}&Category=${filterObject.category}&Make=${filterObject.make}&Name=${filterObject.name}&Model=${filterObject.model}&Gender=${filterObject.gender}&MinPrice=${filterObject.minPrice}&MaxPrice=${filterObject.maxPrice}"));
    var data = jsonDecode(response.body);
    var list = data["items"] as List;
    items = list.map<ItemObject>((json) => ItemObject.fromJson(json)).toList();

    return items;
  }

  factory ItemObject.fromJson(Map<String, dynamic> json) {
    return ItemObject(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        model: json["model"],
        gender: json["gender"],
        retailPrice: json["retailPrice"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        smallImageUrl: json["smallImageUrl"],
        thumbUrl: json["thumbUrl"],
        lowestAsk: json["lowestAsk"],
        highestBid: json["highestBid"]
    );
  }

  void mapFromJson(Map data) {
      id = data['item.id'];
      name = data['item.name'];
      model = data['item.model'];
      gender = data['item.gender'];
      retailPrice = data['item.retailPrice'];
      description = data['item.description'];
      imageUrl = data['item.imageUrl'];
      smallImageUrl = data['item.smallImageUrl'];
      thumbUrl = data['item.thumbUrl'];
      thumbUrl = data['item.thumbUrl'];
  }
}