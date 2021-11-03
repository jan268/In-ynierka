import 'dart:ffi';

class Item {

  String id;
  String name;
  String category;
  String model;
  String gender;
  Double retailPrice;
  String description;
  String imageUrl;
  String smallImageUrl;
  String thumbUrl;

  Item(
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
}