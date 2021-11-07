
import 'dart:convert';

import 'package:http/http.dart';

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
      this.thumbUrl});

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
    Response response = await get(Uri.parse("http://10.0.2.2:5005/api/items/${category}"));
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
        thumbUrl: json["thumbUrl"]
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