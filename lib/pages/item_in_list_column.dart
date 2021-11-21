import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:net_market/objects/filter_object.dart';
import 'package:net_market/objects/item_object.dart';
import 'package:net_market/pages/item_card.dart';
import 'package:net_market/pages/loading.dart';

class ItemInListColumn extends StatefulWidget {
  final FilterObject filterObject;
  const ItemInListColumn({Key? key, required this.filterObject}) : super(key: key);

  @override
  _ItemInListColumnState createState() => _ItemInListColumnState();
}

class _ItemInListColumnState extends State<ItemInListColumn> {

  Future<List<ItemObject>> getData() async {
    List<ItemObject> itemsFromCategory = await ItemObject.getItemsWithFilters(widget.filterObject);
    return itemsFromCategory;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
          } else if (snapshot.hasData) {
            // Extracting data from snapshot object
            List<ItemObject>? items = snapshot.data as List<ItemObject>?;
            return GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
                itemCount: items!.length,
                itemBuilder: (context, index) {
                  ItemObject item = items[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        print("clicked ${item.name}");
                        print("${item.id}");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ItemCard(id: item.id!,)));
                      },
                      child: Container(
                        color: Colors.grey[100],
                        child: SizedBox(
                          width: 150,
                          child: Column(
                            children: [
                              Image.network(item.thumbUrl!),
                              Text(
                                getName(item),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Lowest Ask',
                                style: TextStyle(fontSize: 12, color: Colors.black38),
                              ),
                              Text(
                                getLowestAsk(item),
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
            );
          }
        }

        // Displaying LoadingSpinner to indicate waiting state
        return Loading();
      },

      // Future that needs to be resolved
      // inorder to display something on the Canvas
      future: getData(),
    );
  }

  String getLowestAsk(ItemObject item) {
    if (item.lowestAsk == null) {
      return "-";
    }
    return item.lowestAsk as String;
  }

  String getName(ItemObject item) {
    if (item.name!.length > 28) {
      String name = item.name!.substring(0, 28);
      return name + "...";
    }
    return item.name as String;
  }

  @override
  void initState() {
    super.initState();
  }
}
