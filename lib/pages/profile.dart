import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:net_market/objects/filter_object.dart';
import 'package:net_market/pages/search.dart';
import 'package:net_market/utilities/basic_icons_icons.dart';

import 'home.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Colors.tealAccent,
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: getNavBar(2),
        body: Container(
            child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        Text("Completed"),
                        Text(
                            "0", // Sales completed
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.tealAccent,
                      child: Text(
                        "1", // tu bedzie current Level
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      radius: 40.0,
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        Text("Next Level In"),
                        Text(
                            "3",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 400,
                child: ListView(
                  children: [
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.directions_walk), // do zmiany
                        title: Text("Sneakers"),
                        subtitle: Text("10%"),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.money), // do zmiany
                        title: Text("Streetwear"),
                        subtitle: Text("10%"),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.electrical_services),
                        title: Text("Electronics"),
                        subtitle: Text("10%"),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.watch),
                        title: Text("Collectibles"),
                        subtitle: Text("10%"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
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
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      category: 'SNEAKERS',
                    )));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchPage(
                      category: 'SNEAKERS',
                      filters: FilterObject.category('SNEAKERS'),
                    )));
        break;
      case 2:
        break;
    }
  }
}
