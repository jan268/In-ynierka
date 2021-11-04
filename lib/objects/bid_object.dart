import 'package:net_market/objects/item_object.dart';
import 'package:net_market/objects/size_object.dart';

class BidObject {
  String id;
  ItemObject item;
  SizeObject size;
  String price;
  String userId;
  String expires;
  String buyerFee;

  BidObject.name(this.id, this.item, this.size, this.price, this.userId,
      this.expires, this.buyerFee);
}