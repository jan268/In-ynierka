import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:net_market/objects/filter_object.dart';
import 'package:net_market/pages/search.dart';

class FilterPage extends StatefulWidget {
  final String category;
  const FilterPage({Key? key, required this.category}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  final name = TextEditingController();
  final make = TextEditingController();
  final model = TextEditingController();
  String genderValue = "All";
  String priceValue = "All prices";
  FilterObject filters = FilterObject();

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
                      controller: name,
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
                      controller: make,
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
                      controller: model,
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
                      value: genderValue,
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
                          genderValue = newValue!;
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
                filters.category = widget.category;
                filters.name = getValue(name.text);
                filters.make = getValue(make.text);
                filters.model = getValue(model.text);
                filters.gender = getGender();
                setPriceRange();

                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(category: widget.category, filters: filters, )));
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
                name.clear();
                make.clear();
                model.clear();
                genderValue = 'All';
                priceValue = 'All prices';
              },
              child: Text("CLEAR"),
            ),
          ),
        ],
      ),
    );
  }

  String getValue(String value) {
    if(value == '') {
      return "%20";
    }
    return value;
  }

  String getGender() {
    if(genderValue == "All") {
      return "%20";
    }
    return genderValue;
  }

  void setPriceRange() {
    switch(priceValue) {
      case 'All prices': filters.minPrice = '%20'; filters.maxPrice = '%20'; break;
      case 'Under 100': filters.minPrice = 0 as String?; filters.maxPrice = 100 as String?; break;
      case '100-200': filters.minPrice = 100 as String?; filters.maxPrice = 200 as String?; break;
      case '200-300': filters.minPrice = 200 as String?; filters.maxPrice = 300 as String?; break;
      case '300-400': filters.minPrice = 300 as String?; filters.maxPrice = 400 as String?; break;
      case '400-500': filters.minPrice = 400 as String?; filters.maxPrice = 500 as String?; break;
      case '500+': filters.minPrice = 500 as String?; filters.maxPrice = '%20'; break;
    }
  }
}
