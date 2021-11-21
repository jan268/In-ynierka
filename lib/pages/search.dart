import 'package:flutter/material.dart';
import 'package:net_market/mocks/mocked_lists.dart';
import 'package:net_market/objects/filter_object.dart';
import 'package:net_market/pages/filters.dart';
import 'package:net_market/pages/item_in_list_column.dart';
import 'package:net_market/utilities/basic_icons_icons.dart';

import 'home.dart';

class SearchPage extends StatefulWidget {
  final String category;
  final FilterObject filters;
  const SearchPage({Key? key, required this.category, required this.filters}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  get bottomNavBar => MockedLists().bottomNavBar;
  get categories => MockedLists().categories;

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: getNavBar(1),
      body: Container(
        child: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(category: categories[index], filters: FilterObject.category(categories[index]), )));
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
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 150,
                      child: TextField(
                        controller: myController,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // odpalenie wyszukania
                        setState(() {
                          widget.filters.name = myController.text;
                        });
                      },
                      icon: Icon(
                          Icons.search
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FilterPage(category: widget.category,)));
                      },
                      icon: Icon(
                          Icons.settings
                      ),
                    )
                  ],
                ),
                Divider(color: Colors.black,),
                SizedBox(
                  height: 489,
                  child: Container(
                      color: Colors.white,
                      child: ItemInListColumn(filterObject: widget.filters,)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
      case 0 : Navigator.push(context, MaterialPageRoute(builder: (context) => Home(category: 'Streetwear',))); break;
      case 1 : break;
      case 2 : break; // tu trzeba dodac bedzie ekran uzytkownika
    }
  }
}
