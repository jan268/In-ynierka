import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:net_market/objects/item_card_object.dart';
import 'package:net_market/objects/item_object.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {

  late ItemCardObject itemCardObject = ItemCardObject.item(ItemObject.item("f3f899b0-6571-4f75-9207-f61190e17794", "name", "category", "model", "gender", 2.0, "description", "imageUrl", "smallImageUrl", "thumbUrl"));

  void getData() async {
    var item = await ItemCardObject.getData("f3f899b0-6571-4f75-9207-f61190e17794");
    setState(() {
      itemCardObject = item;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
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
                              onPressed: () {},
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        width: 40,
                                        child: Text(
                                            "${itemCardObject.item!.retailPrice}")), // tu trzeba dac cene Lowest ASK
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
                                          "Price")
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
                child: Image.asset("assets/photos/j1.jpg"),
                // child: Image.network(item.thumbUrl)
              ),
              SizedBox(
                height: 100,
                child: Text(
                    "Jordan 1",
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
}
