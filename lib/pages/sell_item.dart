import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:net_market/objects/item_card_object.dart';
import 'package:net_market/objects/item_object.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SellItem extends StatefulWidget {
  final ItemCardObject itemCardObject;
  final String size;

  const SellItem({Key? key, required this.itemCardObject, required this.size})
      : super(key: key);

  @override
  _SellItemState createState() => _SellItemState();
}

class _SellItemState extends State<SellItem> {
  late ItemCardObject item = widget.itemCardObject;
  final myController = TextEditingController();
  bool buyNow = true;
  int toggleIndex = 1;
  double feeValue = 0;
  String feeString = '';
  String totalString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: SizedBox(
                    height: 200,
                    child: Image.network(item.item!.thumbUrl as String)),
              ),
              SizedBox(
                height: 50,
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Highest Bid: ${getHighestBid(item.item!)}USD",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          VerticalDivider(
                            thickness: 2,
                            width: 20,
                            color: Colors.grey,
                          ),
                          Text(
                            "Lowest Ask : ${getLowestAsk(item.item!)}",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        widget.size,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              ToggleSwitch(
                minWidth: 90.0,
                cornerRadius: 20.0,
                activeBgColors: [
                  [Colors.red[800]!],
                  [Colors.red[800]!]
                ],
                //Color(0xFF40C6BD)
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                initialLabelIndex: toggleIndex,
                totalSwitches: 2,
                labels: ['Place Ask', 'Sell Now'],
                radiusStyle: true,
                onToggle: (index) {
                  setState(() {
                    buyNow = !buyNow;
                    print('switched to: $buyNow');
                    if (buyNow == false) {
                      toggleIndex = 0;
                      myController.clear();
                      feeString = '';
                      totalString = '';
                    } else {
                      toggleIndex = 1;
                      myController.text = getHighestBid(item.item!);
                      feeString = getFeePrice();
                      totalString = getTotalPrice();
                    }
                  });
                },
              ),
              Center(
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Row(
                    children: [
                      SizedBox(
                          width: 50,
                          child: Text(
                            "USD",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                      SizedBox(
                        width: 150,
                        child: TextField(
                          enabled: !buyNow,
                          controller: myController,
                          keyboardType: TextInputType.number,
                          onSubmitted: (String value) {
                            setState(() {
                              feeString = getFeePrice();
                              totalString = getTotalPrice();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  height: 30,
                  width: 200,
                  child: Row(
                    children: [
                      Text(
                        "Fee:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(width: 20,),
                      Text(
                          feeString,
                          style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  height: 30,
                  width: 200,
                  child: Row(
                    children: [
                      Text(
                        "Total Price:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        getTotalPrice(),
                        style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: createActionButton(),
      ),
    );
  }

  RaisedButton createActionButton() {
    if(totalString.isEmpty || totalString == '' || totalString == "--") {
      return RaisedButton(
        onPressed: () {},
        child: Text("Next"),
        color: Colors.grey[400],
      );
    }
    return RaisedButton(
        onPressed: () {
          if (buyNow == true) {
            print("Buy for ${myController.text}");
            sellItemNowNotification();
            // tu bedzie akcja dla buy z cena z tego text
          } else {
            print("Place bid for ${myController.text}");
            placeAskNotification();
            // tu bedzie akcja dla Place Bid z cena z tego text
          }
        },
        child: Text("Next"),
        color: Colors.red[800],
      );
  }

  String getLowestAsk(ItemObject item) {
    if (item.lowestAsk == null) {
      return "--";
    }
    String price = item.lowestAsk as String;
    if (price.contains('.') && checkIfBidTooLong(price)) {
      price =  price.substring(0, price.lastIndexOf('.') + 3);
    }
    return price + "USD";
  }

  String getHighestBid(ItemObject item) {
    if (item.highestBid == null) {
      return "--";
    }
    String price = item.highestBid as String;
    if (price.contains('.') && checkIfBidTooLong(price)) {
      price =  price.substring(0, price.lastIndexOf('.') + 3);
    }
    return price;
  }

  String getTotalPrice() {
    if(myController.text.isEmpty) {
      return "";
    }
    double value = double.parse(myController.text);
    double price = value + feeValue;
    return price.toString();
  }

  String getFeePrice() {
    if(myController.text.isEmpty) {
      return "";
    }
    double value = double.parse(myController.text);
    double fee = (value * 0.1);
    setState(() {
      feeValue = fee;
    });
    var lastIndexOf = fee.toString().lastIndexOf('.');
    return fee.toString().substring(0, lastIndexOf + 3);
  }

  bool checkIfBidTooLong(String highestBid) {
    if (highestBid.substring(highestBid.lastIndexOf('.'), highestBid.length).length > 2) {
      return true;
    }
    return false;
  }

  String getItemName(ItemCardObject itemCardObject) {
    return itemCardObject.item!.name as String;
  }

  failToSellItemNotification() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.red[200],
            title: const Text('Something went wrong!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('We are sorry to announce that an error occurred, please try again.')
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  placeAskNotification() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.green[200],
            title: const Text('Successfully placed ask!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('We are happy to announce that you placed an ask for:'),
                  Text(getItemName(item), style: TextStyle(fontWeight: FontWeight.bold),),

                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  sellItemNowNotification() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.green[200],
            title: const Text('Successfully sold item!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('We are happy to announce that you sold:'),
                  Text(getItemName(item), style: TextStyle(fontWeight: FontWeight.bold),),

                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    myController.text = getHighestBid(item.item!);
    totalString = getTotalPrice();
    feeString = getFeePrice();
  }
}
