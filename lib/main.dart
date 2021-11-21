import 'package:flutter/material.dart';
import 'package:net_market/objects/filter_object.dart';
import 'package:net_market/objects/item_card_object.dart';
import 'package:net_market/pages/account.dart';
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
    initialRoute: "/",
    routes: {
      '/' : (context) => Loading(),
      '/login_screen' : (context) => LoginScreen(),
      '/register' : (context) => Register(),
      '/home' : (context) => Home(category: 'SNEAKERS',),
      '/buy_item' : (context) => BuyItem(itemCardObject: ItemCardObject(), size: '',),
      '/item_card' : (context) => ItemCard(id: '',),
      '/search' : (context) => SearchPage(category: 'SNEAKERS', filters: FilterObject.category("SNEAKERS"),),
      '/filters' : (context) => FilterPage(category: '',),
      '/account' : (context) => AccountPage(),
    },
  ));
}