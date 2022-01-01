import 'package:flutter/material.dart';
import 'package:net_market/mocks/mocked_lists.dart';
import 'package:net_market/objects/ask_object.dart';
import 'package:net_market/objects/filter_object.dart';
import 'package:net_market/pages/search.dart';
import 'package:net_market/utilities/basic_icons_icons.dart';

import 'home.dart';

class AsksPage extends StatefulWidget {
  const AsksPage({Key? key}) : super(key: key);

  @override
  _AsksPageState createState() => _AsksPageState();
}

class _AsksPageState extends State<AsksPage> {
  late List<AskObject> askObjects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Asks"),
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
                    SizedBox(
                        height: 30,
                        width: 100,
                        child: Center(child: Text("Name"))),
                    SizedBox(
                        height: 30,
                        width: 40,
                        child: Center(child: Text("Price"))),
                    SizedBox(
                        height: 30,
                        width: 40,
                        child: Center(child: Text("Fee"))),
                    SizedBox(
                        height: 30,
                        width: 40,
                        child: Center(child: Text("Size"))),
                    SizedBox(
                        height: 30,
                        width: 50,
                        child: Center(child: Text("Lowest Ask"))),
                    // SizedBox(
                    //     height: 30,
                    //     width: 50,
                    //     child: Center(child: Text("Highest Bid"))),
                    SizedBox(
                        height: 30,
                        width: 75,
                        child: Center(child: Text("Expires"))),
                  ],
                ),
              ),
              // buildInkWell()
              SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  builder: (ctx, snapshot) {
                    // Checking if future is resolved or not
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If we got an error
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error} occured',
                            style: TextStyle(fontSize: 18),
                          ),
                        );

                        // if we got our data
                      }else if (snapshot.hasData) {
                        // Extracting data from snapshot object
                        List<AskObject>? items =
                            snapshot.data as List<AskObject>?;
                        if(items!.isEmpty) {
                          return SizedBox();
                        }
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            AskObject item = items[index];
                            print('ID: ${item.id}');
                            return InkWell(
                              onTap: () {
                                editDeletePopUp(item.id!);
                              },
                              child: Card(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        height: 30,
                                        width: 100,
                                        child: Center(
                                            child: Text(item.item!.name!))),
                                    SizedBox(
                                        height: 30,
                                        width: 40,
                                        child: Center(child: Text(getNumber(item.price!)))),
                                    SizedBox(
                                        height: 30,
                                        width: 40,
                                        child:
                                            Center(child: Text(getNumber(item.sellerFee!)))),
                                    SizedBox(
                                        height: 30,
                                        width: 40,
                                        child: Center(
                                            child: Text(item.size!.value!))),
                                    SizedBox(
                                        height: 30,
                                        width: 50,
                                        child: Center(
                                            child: Text(getNumber(checkForNull(item.item!.lowestAsk))))),
                                    // SizedBox(
                                    //     height: 30,
                                    //     width: 50,
                                    //     child: Center(
                                    //         child: Text(getNumber(checkForNull(item.item!.highestBid))))),
                                    SizedBox(
                                        height: 30,
                                        width: 75,
                                        child:
                                            Center(child: Text(getExpirationDate(item.expires!)))),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }

                    // Displaying LoadingSpinner to indicate waiting state
                    return MockedLists.loadingWidget();
                  },

                  // Future that needs to be resolved
                  // inorder to display something on the Canvas
                  future: getData(),
                ),
              )
            ],
          ),
        )));
  }

  getExpirationDate(String date) {
      var lastIndexOfT = date.lastIndexOf("T");
      var years = date.substring(0, lastIndexOfT);
      var hours = date.substring(lastIndexOfT + 1, lastIndexOfT + 9);
      return years + hours;
  }

  // InkWell buildInkWell() {
  //   return InkWell(
  //     onTap: editDeletePopUp,
  //     child: Card(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           SizedBox(
  //               height: 30,
  //               width: 100,
  //               child: Center(child: Text("Jordan 1 Retro High Tie Dye (W)"))),
  //           SizedBox(
  //               height: 30, width: 40, child: Center(child: Text("120.00"))),
  //           SizedBox(
  //               height: 30, width: 40, child: Center(child: Text("12.00"))),
  //           SizedBox(height: 30, width: 40, child: Center(child: Text("14"))),
  //           SizedBox(
  //               height: 30, width: 50, child: Center(child: Text("No asks"))),
  //           SizedBox(
  //               height: 30, width: 50, child: Center(child: Text("120.00"))),
  //           SizedBox(
  //               height: 30,
  //               width: 50,
  //               child: Center(child: Text("Dec 27, 2021"))),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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

  Future<List<AskObject>> getData() async {
    List<AskObject> asks = await AskObject.getAsks();
    return asks;
  }

  Future<void> deleteAsk(String id) async {
    bool status = await AskObject.deleteAsk(id);
    if(status) {
      setState(() {
      });
    }
  }

  Future editDeletePopUp(String id) {
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
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                          deleteAsk(id);
                          Navigator.pop(context);
                      },
                      child: Text("Delete"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Exit"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  String checkForNull(String? value) {
    if(value == null) {
      return "--";
    }
    return value;
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

  String getNumber(String number) {
    return number.substring(0, number.lastIndexOf(".") + 3);
  }

  String getName(String name) {
    if (name.length > 23) {
      var substring = name.substring(0, 23);
      return substring + "...";
    } else
      return name;
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
