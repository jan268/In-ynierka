import 'package:flutter/material.dart';
import 'package:net_market/objects/bid_object.dart';
import 'package:net_market/objects/filter_object.dart';
import 'package:net_market/pages/search.dart';
import 'package:net_market/utilities/basic_icons_icons.dart';

import 'home.dart';

class BidsPage extends StatefulWidget {
  const BidsPage({Key? key}) : super(key: key);

  @override
  _BidsPageState createState() => _BidsPageState();
}

class _BidsPageState extends State<BidsPage> {

  late BidObject bidObject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bids"),
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
                        SizedBox(height: 30, width: 40, child: Center(child: Text("Price"))),
                        SizedBox(height: 30, width: 40, child: Center(child: Text("Fee"))),
                        SizedBox(height: 30, width: 40, child: Center(child: Text("Size"))),
                        SizedBox(height: 30, width: 50, child: Center(child: Text("Lowest Ask"))),
                        SizedBox(height: 30, width: 50, child: Center(child: Text("Highest Bid"))),
                        SizedBox(height: 30, width: 50, child: Center(child: Text("Expires"))),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: editDeletePopUp,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 30, width: 100, child: Center(child: Text("Jordan 1 Retro High Tie Dye (W)"))),
                          SizedBox(height: 30, width: 40, child: Center(child: Text("120.00"))),
                          SizedBox(height: 30, width: 40, child: Center(child: Text("12.00"))),
                          SizedBox(height: 30, width: 40, child: Center(child: Text("14"))),
                          SizedBox(height: 30, width: 50, child: Center(child: Text("No asks"))),
                          SizedBox(height: 30, width: 50, child: Center(child: Text("120.00"))),
                          SizedBox(height: 30, width: 50, child: Center(child: Text("Dec 27, 2021"))),
                        ],
                      ),
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
