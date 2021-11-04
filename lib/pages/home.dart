import 'package:flutter/material.dart';
import 'package:net_market/mocks/mocked_lists.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  get bottomNavBar => MockedLists().bottomNavBar;
  get categories => MockedLists().categories;
  get brands => MockedLists().brands;
  get items => MockedLists().items;
  // get items => HomeService().fetchData("CLOTHES");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNavBar,
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
                      return categories.elementAt(index);
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
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return items.elementAt(index);
                      },
                    //   separatorBuilder: (BuildContext context, int index) {
                    //   return Container(color: Colors.white ,child: SizedBox(width: 10));
                    // },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}
