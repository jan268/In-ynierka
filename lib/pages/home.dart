import 'package:flutter/material.dart';
import 'package:net_market/mocks/mocked_lists.dart';
import 'package:net_market/objects/filter_object.dart';
import 'package:net_market/pages/account.dart';
import 'package:net_market/pages/item_in_list.dart';
import 'package:net_market/pages/search.dart';
import 'package:net_market/utilities/basic_icons_icons.dart';

class Home extends StatefulWidget {
  final String category;
  const Home({Key? key, required this.category}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  get categories => MockedLists().categories;
  get brands => MockedLists().brands;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: getNavBar(0),
      body: Container(
        child: SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Container(
                    color: Colors.grey[100],
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Home(category: categories[index],)));
                        },
                        child: Text(
                          categories[index],
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    },
      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 2, 0),
                  child: SizedBox(
                    height: 30,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Popular Brands",
                        style: TextStyle(
                          wordSpacing: 3,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Container(
                    color: Colors.grey[100],
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: brands.length,
                      itemBuilder: (BuildContext context, int index) {
                        return brands.elementAt(index);
                      }, separatorBuilder: (BuildContext context, int index) {
                        return Container(color: Colors.white ,child: SizedBox(width: 20));
                    },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 2, 0),
                  child: SizedBox(
                    height: 30,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Most Popular",
                        style: TextStyle(
                            wordSpacing: 3,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: Container(
                    color: Colors.white,
                    child: ItemInList(category: widget.category,)
                  ),
                ),
              ],
            ),
          ),
        )
      )
    );
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
      case 0 : break;
      case 1 : Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(category: widget.category, filters: FilterObject.category(widget.category),))); break;
      case 2 : Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage())); break;
    }
  }
}
