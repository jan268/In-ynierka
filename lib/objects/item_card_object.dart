import 'dart:convert';

import 'package:http/http.dart';
import 'package:net_market/objects/ask_object.dart';
import 'package:net_market/objects/bid_object.dart';
import 'package:net_market/objects/item_object.dart';

class ItemCardObject {
  ItemObject? item;
  AskObject? lowestAsk;
  List<AskObject>? asks;
  BidObject? highestBid;
  List<BidObject>? bids;

  ItemCardObject({this.item});

  ItemCardObject.item(this.item);

  ItemCardObject.name(
      this.item, this.lowestAsk, this.asks, this.highestBid, this.bids);

  Future<ItemCardObject> getData(String id) async {
      // make request
      Response response = await get(Uri.parse("http://10.0.2.2:5005/api/items/${id}"));
      var data = jsonDecode(response.body);

      return data.map<ItemCardObject>((json) => ItemCardObject.fromJson(json));

      // item!.mapFromJson(data);
  }

  factory ItemCardObject.fromJson(Map<String, dynamic> json) {
    return ItemCardObject(
        item: ItemObject.fromJson(json["item"])
    );
  }

}