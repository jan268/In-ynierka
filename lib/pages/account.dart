import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:net_market/objects/account_object.dart';
import 'package:net_market/objects/decoded_token_object.dart';
import 'package:net_market/objects/filter_object.dart';
import 'package:net_market/pages/login_screen.dart';
import 'package:net_market/pages/profile.dart';
import 'package:net_market/pages/search.dart';
import 'package:net_market/pages/settings.dart';
import 'package:net_market/pages/bids.dart';
import 'package:net_market/pages/transactions.dart';
import 'package:net_market/utilities/basic_icons_icons.dart';
import 'package:net_market/utilities/user_secure_storage.dart';

import 'asks.dart';
import 'home.dart';
import 'loading.dart';

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
                    title: Center(child: Text("Jan Witek")), // tu bedzie imie uzytkownika
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    navigateToProfile(context);
                  },
                  leading: Icon(Icons.person),
                  title: Text("Profile"),
                  subtitle: Text("Check profile details"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    navigateToBids(context);
                  },
                  leading: Icon(CupertinoIcons.cube_box),
                  title: Text("Bids"),
                  subtitle: Text("Check bids"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    navigateToAsks(context);
                  },
                  leading: Icon(Icons.monetization_on_sharp),
                  title: Text("Asks"),
                  subtitle: Text("Check asks"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    navigateToTransactions(context);
                  },
                  leading: Icon(Icons.list),
                  title: Text("Transactions"),
                  subtitle: Text("Check history of transactions"),
                )
              ),
              Card(
                  child: ListTile(
                    onTap: () {
                      navigateToSettings(context);
                    },
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                    subtitle: Text("Change password"),
                  )
              ),
              Card(
                  child: ListTile(
                    onTap: () {
                      UserSecureStorage.setJwt('');
                      navigateToLogin(context);
                    },
                    leading: Icon(Icons.logout),
                    title: Text("Log out"),
                    subtitle: Text("You will be logged out"),
                  )
              ),
            ],
          )
        ),
      ),
    );
  }

  Future<dynamic> navigateToProfile(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
  Future<dynamic> navigateToBids(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => BidsPage()));
  Future<dynamic> navigateToAsks(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => AsksPage()));
  Future<dynamic> navigateToTransactions(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionsPage()));
  Future<dynamic> navigateToSettings(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
  Future<dynamic> navigateToLogin(BuildContext context) => Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);

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
