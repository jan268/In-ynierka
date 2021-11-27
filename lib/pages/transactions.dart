import 'package:flutter/material.dart';
import 'package:net_market/objects/filter_object.dart';
import 'package:net_market/pages/search.dart';
import 'package:net_market/utilities/basic_icons_icons.dart';

import 'home.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Transactions"),
          backgroundColor: Colors.tealAccent,
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: getNavBar(2),
        body: Container(
            child: SafeArea(
              child: Column(
                children: [
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 30, width: 100, child: Center(child: Text("Name"))),
                        SizedBox(height: 30, width: 70, child: Center(child: Text("Category"))),
                        SizedBox(height: 30, width: 80, child: Center(child: Text("Start date"))),
                        SizedBox(height: 30, width: 50, child: Center(child: Text("Total cost"))),
                        SizedBox(height: 30, width: 50, child: Center(child: Text("Status"))),
                      ],
                    ),
                  ),
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 30, width: 100, child: Center(child: Text("Jordan 1 Retro High Tie Dye (W)"))),
                        SizedBox(height: 30, width: 70, child: Center(child: Text("Sneakers"))),
                        SizedBox(height: 30, width: 80, child: Center(child: Text("11/27/2021 11:41:35 AM"))),
                        SizedBox(height: 30, width: 50, child: Center(child: Text("132.00"))),
                        SizedBox(height: 30, width: 50, child: Center(child: Text("Started"))),
                      ],
                    ),
                  ),
                ],
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

  editDeletePopUp() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {}, // tu do edycji
                      child: Text("Edit"),
                      style : ButtonStyle(
                        backgroundColor:  MaterialStateProperty.all<Color>(Colors.green),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {}, // tu do usuwania
                      child: Text("Delete"),
                      style : ButtonStyle(
                        backgroundColor:  MaterialStateProperty.all<Color>(Colors.red),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {Navigator.pop(context);},
                      child: Text("Exit"),
                      style : ButtonStyle(
                        backgroundColor:  MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }
    );
  }

  @override
  void initState() {
    super.initState();

    // metoda do pobrania Bida;
    // setState(() {
    //   bidObject = pobrany bid
    // });
  }

  void onTabTapped(int index) {
    switch(index){
      case 0 : Navigator.push(context, MaterialPageRoute(builder: (context) => Home(category: 'SNEAKERS',))); break;
      case 1 : Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(category: 'SNEAKERS', filters: FilterObject.category('SNEAKERS'),))); break;
      case 2 : break;
    }
  }


  String getName(String name) {
    if(name.length > 23) {
      var substring = name.substring(0, 23);
      return substring + "...";
    }
    else return name;
  }
  headers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: 30, width: 100, child: Center(child: Text("Name"))),
        Text("Price"),
        Text("Fee"),
        Text("Size"),
        Text("Lowest Ask"),
        Text("Highest Bid"),
        Text("Expires"),
      ],
    );
  }
}
