import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  String dropdownValue = "All";
  String priceValue = "All prices";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SafeArea(
          child:  Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Name:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: myController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Make:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: myController2,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Model:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: myController3,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Gender:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.transgender),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Color(0xFF40C6BD)),
                      underline: Container(
                        height: 2,
                        color: Color(0xFF40C6BD),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['All', 'Men', 'Women', 'Kids', 'Unisex']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Price:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      child: DropdownButton<String>(
                        value: priceValue,
                        icon: const Icon(CupertinoIcons.money_dollar),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Color(0xFF40C6BD)),
                        underline: Container(
                          height: 2,
                          color: Color(0xFF40C6BD),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            priceValue = newValue!;
                          });
                        },
                        items: <String>['All prices', 'Under 100', '100-200', '200-300', '300-400', '400-500', '500+']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width/2,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF40C6BD)),
              ),
              onPressed: () {
                // powrot do ekranu wyszukiwania z (przekazac dane filtrow)
              },
              child: Text("APPLY"),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width/2,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                // powrot do ekranu wyszukiwania z (przekazac dane filtrow)
              },
              child: Text("CLEAR"),
            ),
          ),
        ],
      ),
    );
  }
}
