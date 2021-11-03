import 'package:flutter/material.dart';
import 'package:net_market/pages/buy_item.dart';
import 'package:net_market/pages/item_card.dart';
import 'package:net_market/pages/home.dart';
import 'package:net_market/pages/loading.dart';
import 'package:net_market/pages/login_screen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/home",
    routes: {
      '/' : (context) => Loading(),
      '/home' : (context) => Home(),
      '/login_screen' : (context) => LoginScreen(),
      '/buy_item' : (context) => BuyItem(),
      '/item_card' : (context) => ItemCard(),
    },
  ));
}