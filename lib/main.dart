import 'package:flutter/material.dart';
import 'package:net_market/objects/item_card_object.dart';
import 'package:net_market/objects/item_object.dart';
import 'package:net_market/pages/buy_item.dart';
import 'package:net_market/pages/item_card.dart';
import 'package:net_market/pages/home.dart';
import 'package:net_market/pages/loading.dart';
import 'package:net_market/pages/login_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/home",
    routes: {
      '/' : (context) => Loading(),
      '/home' : (context) => Home(category: 'Streetwear',),
      '/login_screen' : (context) => LoginScreen(),
      '/buy_item' : (context) => BuyItem(itemCardObject: ItemCardObject(), size: '',),
      '/item_card' : (context) => ItemCard(id: '',),
    },
  ));
}