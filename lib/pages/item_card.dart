import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:net_market/objects/item_card_object.dart';
import 'package:net_market/objects/item_object.dart';
import 'package:net_market/pages/buy_item.dart';

class ItemCard extends StatefulWidget {
  final String id;
  const ItemCard({Key? key, required this.id}) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {

  String? size = "L";
  ItemCardObject itemCardObject = ItemCardObject.item(ItemObject.item("f3f899b0-6571-4f75-9207-f61190e17794", "name", "category", "model", "gender", 2.0, "description", "imageUrl", "smallImageUrl", "https://images.stockx.com/images/adidas-Ivy-Park-Knit-Logo-Dress-Dark-Green-Green-Tint-Yellow-Tint.jpg?fit=fill&bg=FFFFFF&w=480&h=320&auto=compress&q=90&dpr=1&trim=color&updated_at=1619146048&pad=0&fm=webp"));

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 64,
                      width: 80,
                      child: Column(
                        children: [
                          Text("Size"),
                          TextButton(
                            onPressed: () {}, // tu bedzie wybieranie size
                            child: Text("All"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 120,
                      child: Column(
                        children: [
                          ElevatedButton(
                              style : ButtonStyle(
                                backgroundColor:  MaterialStateProperty.all<Color>(Colors.green),
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BuyItem(itemCardObject: itemCardObject, size: size!,)));
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width: 40,
                                        child: Text(
                                            getLowestAsk(itemCardObject))),
                                    SizedBox(
                                      width: 40,
                                        child: Text("Buy", style: TextStyle(fontSize: 20),)
                                    ),
                                  ],
                                ),
                              )
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("View All Asks"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 120,
                      child: Column(children: [
                        ElevatedButton(
                            style : ButtonStyle(
                              backgroundColor:  MaterialStateProperty.all<Color>(Colors.red),
                            ),
                            onPressed: () {},
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                      child: Text(
                                          getHighestBid(itemCardObject))
                                  ), // tu trzeba dac cene Lowest ASK
                                  SizedBox(
                                      child: Text("Sell", style: TextStyle(fontSize: 20),)
                                  ),
                                ],
                              ),
                            )
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("View All Bids"),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: 400,
                child: Image.network(itemCardObject.item!.thumbUrl as String)
              ),
              SizedBox(
                height: 100,
                child: Text(
                    itemCardObject.item!.name as String,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ), //item.name
              )
            ],
          ),
        ),
      ),
    );
  }

  String getHighestBid(ItemCardObject item) {
    if (item.highestBid == null) {
      return "-";
    }
    return item.highestBid as String;
  }

  String getLowestAsk(ItemCardObject item) {
    if (item.lowestAsk == null) {
      return "-";
    }
    return item.lowestAsk as String;
  }
}
