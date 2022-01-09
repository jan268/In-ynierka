import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:net_market/mocks/mocked_lists.dart';
import 'package:net_market/objects/item_card_object.dart';
import 'package:net_market/objects/item_object.dart';
import 'package:net_market/pages/buy_item.dart';
import 'package:net_market/pages/sell_item.dart';

class ItemCard extends StatefulWidget {
  final String category;
  final String id;

  const ItemCard({Key? key, required this.id, required this.category})
      : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {

  String? size = "None";
  ItemCardObject itemCardObject = ItemCardObject.item(ItemObject.item(
      "f3f899b0-6571-4f75-9207-f61190e17794",
      "name",
      "category",
      "model",
      "gender",
      2.0,
      "description",
      "imageUrl",
      "smallImageUrl",
      "https://images.stockx.com/images/adidas-Ivy-Park-Knit-Logo-Dress-Dark-Green-Green-Tint-Yellow-Tint.jpg?fit=fill&bg=FFFFFF&w=480&h=320&auto=compress&q=90&dpr=1&trim=color&updated_at=1619146048&pad=0&fm=webp"));

  void getData(String id) async {
    var item = await ItemCardObject.getData(id);
    setState(() {
      itemCardObject = item;
    });
  }

  @override
  void initState() {
    super.initState();
    getData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    getData(widget.id);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 64, width: 80, child: getSizeWidget()),
                      SizedBox(
                        height: 70,
                        width: 120,
                        child: Column(
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green),
                                ),
                                onPressed: () {
                                  if(streetwearNoSize() || sneakersNoSize()) {
                                    if(widget.category == "SNEAKERS") {
                                      shoesSizePopUp();
                                    } else clothesSizePopUp();
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BuyItem(
                                                  itemCardObject: itemCardObject,
                                                  size: size!,
                                                )));
                                  }
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                          width: 40,
                                          child:
                                              Text(getLowestAsk(itemCardObject))),
                                      SizedBox(
                                          width: 40,
                                          child: Text(
                                            "Buy",
                                            style: TextStyle(fontSize: 20),
                                          )),
                                    ],
                                  ),
                                )),
                            // TextButton(
                            //   onPressed: () {},
                            //   child: Text("View All Asks"),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 120,
                        child: Column(children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(Colors.red),
                              ),
                              onPressed: () {
                                if(streetwearNoSize() || sneakersNoSize()) {
                                  if(widget.category == "SNEAKERS") {
                                    shoesSizePopUp();
                                  } else clothesSizePopUp();
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SellItem(
                                            itemCardObject: itemCardObject,
                                            size: size!,
                                          )));
                                }
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        child:
                                            Text(getHighestBid(itemCardObject))),
                                    SizedBox(
                                        child: Text(
                                      "Sell",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                  ],
                                ),
                              )),
                          // TextButton(
                          //   onPressed: () {},
                          //   child: Text("View All Bids"),
                          // ),
                        ]),
                      ),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(
                    height: 400,
                    child:
                        Image.network(itemCardObject.item!.thumbUrl as String)),
                SizedBox(
                  height: 70,
                  child: Text(
                    itemCardObject.item!.name as String,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ), //item.name
                ),
                Divider(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Model:",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "Make:",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left
                            ),
                            Text(
                              "Retail Price:",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "${itemCardObject.item!.model}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "${itemCardObject.item!.make}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "${itemCardObject.item!.retailPrice} \$",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    Center(
                      child: Text(
                        getDescription(),
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getDescription() {
    String description = itemCardObject.item!.description as String;
    if(description.isEmpty) {
      return "No description";
    }
    return description;
  }

  bool streetwearNoSize() => size == "None" && widget.category == "STREETWEAR";
  bool sneakersNoSize() => size == "None" && widget.category == "SNEAKERS";

  getSizeWidget() {
    if (widget.category == "STREETWEAR") {
      return Column(
        children: [
          Text("Size"),
          TextButton(
            onPressed: clothesSizePopUp,
            child: Text(size!),
          ),
        ],
      );
    } else if (widget.category == "SNEAKERS") {
      return Column(
        children: [
          Text("Size"),
          TextButton(
            onPressed: shoesSizePopUp, // tu bedzie wybieranie size
            child: Text(size!),
          ),
        ],
      );
    } else {
      return Column();
    }
  }

  shoesSizePopUp() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 350,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: ListView.builder(
                        itemCount: MockedLists().shoesSize.length,
                        itemBuilder: (BuildContext context, int index) {
                          String shoeSize = MockedLists().shoesSize[index];
                          return ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  size = shoeSize;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(shoeSize),
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.tealAccent),
                              )
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  clothesSizePopUp() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 300,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 250,
                      child: ListView.builder(
                        itemCount: MockedLists().clothesSize.length,
                        itemBuilder: (BuildContext context, int index) {
                          String clothSize = MockedLists().clothesSize[index];
                          return ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  size = clothSize;
                                });
                                Navigator.pop(context);
                              },
                              child: Text(clothSize),
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.tealAccent),
                              )
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  String getHighestBid(ItemCardObject item) {
    String? highestBid = item.item!.highestBid;
    if (highestBid == null) {
      return "-";
    }
    if (highestBid.contains('.') && checkIfBidTooLong(highestBid)) {
      return highestBid.substring(0, highestBid.lastIndexOf('.') + 3);
    }
    return highestBid;
  }

  bool checkIfBidTooLong(String highestBid) {
    if (highestBid.substring(highestBid.lastIndexOf('.'), highestBid.length).length > 2) {
      return true;
    }
    return false;
  }

  String getLowestAsk(ItemCardObject item) {
    String? lowestAsk = item.item!.lowestAsk;
    if (lowestAsk == null) {
      return "-";
    }
    if (lowestAsk.contains('.') && checkIfBidTooLong(lowestAsk)) {
      return lowestAsk.substring(0, lowestAsk.lastIndexOf('.') + 3);
    }
    return lowestAsk;
  }
}
