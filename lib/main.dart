import 'package:flutter/material.dart';
import 'package:net_market/objects/filter_object.dart';
import 'package:net_market/objects/item_card_object.dart';
import 'package:net_market/pages/buy_item.dart';
import 'package:net_market/pages/filters.dart';
import 'package:net_market/pages/home.dart';
import 'package:net_market/pages/item_card.dart';
import 'package:net_market/pages/loading.dart';
import 'package:net_market/pages/login_screen.dart';
import 'package:net_market/pages/register.dart';
import 'package:net_market/pages/search.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/login_screen",
    routes: {
      '/' : (context) => Loading(),
      '/home' : (context) => Home(category: 'SNEAKERS',),
      '/login_screen' : (context) => LoginScreen(),
      '/buy_item' : (context) => BuyItem(itemCardObject: ItemCardObject(), size: '',),
      '/item_card' : (context) => ItemCard(id: '',),
      '/search' : (context) => SearchPage(category: 'SNEAKERS', filters: FilterObject.category("SNEAKERS"),),
      '/filters' : (context) => FilterPage(category: '',),
      '/register' : (context) => Register(),
    },
  ));
}