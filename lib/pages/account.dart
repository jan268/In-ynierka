import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:net_market/objects/account_object.dart';
import 'package:net_market/objects/decoded_token_object.dart';
import 'package:net_market/objects/filter_object.dart';
import 'package:net_market/pages/search.dart';
import 'package:net_market/utilities/basic_icons_icons.dart';

import 'home.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  AccountObject account = AccountObject();
  DecodedTokenObject tokenObject = DecodedTokenObject();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: getNavBar(2),
      body: Container(
        child: SafeArea(
          child: ListView(
            children: [
              Card(
                child: Container(
                  color: Colors.tealAccent,
                  child: ListTile(
                    title: Center(child: Text("Jan Witek")),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Account Settings"),
                  subtitle: Text("Change password"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(CupertinoIcons.cube_box),
                  title: Text("Buying"),
                  subtitle: Text("Check what you bought"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.trending_up), // tu do zmiany ikona
                  title: Text("Selling"),
                  subtitle: Text("Check what you sold"),
                ),
              )
            ],
          )
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    setState(() {
      // account = AccountObject.getAccount() as AccountObject;
      // tokenObject = DecodedTokenObject.getDecodedToken();
    });
  }

  Widget getNavBar(int index) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onTabTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              BasicIcons.trending_up,
              color: Colors.tealAccent,
            ),
            label: 'Trending'),
        BottomNavigationBarItem(
            icon: Icon(
              BasicIcons.search,
              color: Colors.tealAccent,
            ),
            label: 'Search'),
        BottomNavigationBarItem(
            icon: Icon(
              BasicIcons.person_outline,
              color: Colors.tealAccent,
            ),
            label: 'Profile'),
      ],
    );
  }

  void onTabTapped(int index) {
    switch(index){
      case 0 : Navigator.push(context, MaterialPageRoute(builder: (context) => Home(category: 'SNEAKERS',))); break;
      case 1 : Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(category: 'SNEAKERS', filters: FilterObject.category('SNEAKERS'),))); break;
      case 2 : break;
    }
  }

}
