import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:net_market/objects/item.dart';
import 'package:http/http.dart' as http;

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  fetchData(String id) async {
    var response =
        await http.get(Uri.parse('http://localhost:5005/api/items/$id'));
    var jsonData = jsonDecode(response.body);
    return Item(
        jsonData["Id"],
        jsonData["Name"],
        jsonData["Category"],
        jsonData["Model"],
        jsonData["Gender"],
        jsonData["RetailPrice"],
        jsonData["Description"],
        jsonData["ImageUrl"],
        jsonData["SmallImageUrl"],
        jsonData["ThumbImageUrl"]);
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
                                            "Price")), // tu trzeba dac cene Lowest ASK
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
