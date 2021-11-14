import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:net_market/objects/item_card_object.dart';
import 'package:net_market/objects/item_object.dart';
import 'package:toggle_switch/toggle_switch.dart';

class BuyItem extends StatefulWidget {
  final ItemCardObject itemCardObject;
  final String size;
  const BuyItem({Key? key, required this.itemCardObject, required this.size}) : super(key: key);

  @override
  _BuyItemState createState() => _BuyItemState();
}

class _BuyItemState extends State<BuyItem> {

  late ItemCardObject item = widget.itemCardObject;
  final myController = TextEditingController();
  bool buyNow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView (
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    height: 200,
                      child: Image.network(item.item!.thumbUrl as String)
                  ),
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
                                "Highest Bid: ${getHighestBid(item.item!)}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              VerticalDivider(
                                thickness: 2,
                                width: 20,
                                color: Colors.grey,
                              ),
                              Text(
                                "Lowest Ask : ${getLowestAsk(item.item!)}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                        ),
                      ),
                      Center(
                        child: Text(
                          widget.size,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ToggleSwitch(
                  minWidth: 90.0,
                  cornerRadius: 20.0,
                  activeBgColors: [[Colors.green[800]!], [Colors.green[800]!]],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: 1,
                  totalSwitches: 2,
                  labels: ['Place Bid', 'Buy Now'],
                  radiusStyle: true,
                  onToggle: (index) {
                    buyNow = !buyNow;
                    print('switched to: $buyNow');
                  },
                ),
                Center(
                  child: SizedBox(
                    height: 100,
                    width: 200,
                    child: Row(
                      children: [
                        SizedBox(
                            width: 50,child: Text(
                            "USD",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        )
                        ),
                        SizedBox(
                          width: 150,
                          child: TextField(
                            controller: myController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      bottomNavigationBar: BottomAppBar(
        child: RaisedButton(
          onPressed: () {
            if (buyNow == true) {
              print("Buy for ${myController.text}");
              // tu bedzie akcja dla buy z cena z tego text
            }
            else {
              print("Place bid for ${myController.text}");
              // tu bedzie akcja dla Place Bid z cena z tego text
            }
          },
          child: Text("Next"),
          color: Colors.green[800],
        ),
      ),
    );
  }

  String getLowestAsk(ItemObject item) {
    if (item.lowestAsk == null) {
      return "--";
    }
    String price = item.lowestAsk as String;
    return price + "USD";
  }

  String getHighestBid(ItemObject item) {
    if (item.highestBid == null) {
      return "--";
    }
    String price =  item.highestBid as String;
    return price + "USD";
  }
}
