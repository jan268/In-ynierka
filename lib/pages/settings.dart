
import 'package:flutter/material.dart';
import 'package:net_market/objects/filter_object.dart';
import 'package:net_market/pages/search.dart';
import 'package:net_market/utilities/basic_icons_icons.dart';

import 'home.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  String profileName = "Not provided";
  String emailAddress = "Not provided";
  String paypalEmail = "Not provided";
  String billingAddress = "Not provided";
  bool changePasswordButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          backgroundColor: Colors.tealAccent,
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: getNavBar(2),
        body: Container(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: ListView(
                      children: [
                        Card(
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    SizedBox(width: 20,),
                                    Text(
                                      "Profile",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      child: Column(
                                        children: [
                                          Text(
                                              "Name", // Sales completed
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                          Text(
                                              profileName
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: Column(
                                        children: [
                                          Text(
                                              "Email Address", // Sales completed
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                          Text(
                                              emailAddress
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {},
                                      ),
                                    )
                                  ],
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                        resetForm();
                                    },
                                    child: Text("Reset Password"),
                                    style: ButtonStyle(
                                      backgroundColor:  MaterialStateProperty.all<Color>(Colors.red),
                                    ),
                                )
                              ],
                            )
                        ),
                        Card(
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    SizedBox(width: 20,),
                                    Text(
                                        "Billing Info",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      child: Column(
                                        children: [
                                          Text(
                                              "Paypal email", // Sales completed
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                          Text(
                                              paypalEmail
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: Column(
                                        children: [
                                          Text(
                                              "Billing Address", // Sales completed
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                          Text(
                                              billingAddress
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {},
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                        ),
                        Card(
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    SizedBox(width: 20,),
                                    Text(
                                      "Shipping Info",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      child: Column(
                                        children: [
                                          Text(
                                              "Shipping Address", // Sales completed
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                          Text(
                                              billingAddress
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {},
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

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

  resetForm() {
    final email = TextEditingController();
    final oldPassword = TextEditingController();
    final newPassword = TextEditingController();
    final confirmNewPassword = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Stack(
                children: [
                    Column(
                      children: [
                        Align(child: Text("Email"), alignment: Alignment.centerLeft,),
                        Container(
                          decoration: boxDecoration(),
                          child: TextField(
                            controller: email,
                          ),
                        ),
                        SizedBox(height: 30,),
                        Align(child: Text("Old Password"), alignment: Alignment.centerLeft,),
                        Container(
                          decoration: boxDecoration(),
                          child: TextField(
                            controller: oldPassword,
                          ),
                        ),
                        SizedBox(height: 30,),
                        Align(child: Text("New Password"), alignment: Alignment.centerLeft,),
                        Container(
                          decoration: boxDecoration(),
                          child: TextField(
                            controller: newPassword,
                          ),
                        ),
                        SizedBox(height: 30,),
                        Align(child: Text("Confirm New Password"), alignment: Alignment.centerLeft,),
                        Container(
                          decoration: boxDecoration(),
                          child: TextField(
                            controller: confirmNewPassword,
                          ),
                        ),
                        SizedBox(height: 100,),
                        Row(
                          children: [
                            RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Exit"),
                            ),
                            RaisedButton(
                              onPressed: changePasswordButton ? () {
                                  sendRequest();
                              } : null,
                              child: Text("Change Password"),
                            )
                          ],
                        )
                      ],
                    )
                ],
              ),
          );
        }
    );
  }

  @override
  void initState() {
    super.initState();
    // email.addListener(() {
    //   final changePassword = email.text.isNotEmpty;
    //   setState(() {
    //     this.changePasswordButton = changePassword;
    //   });
    // });
  }

  sendRequest() {

  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
                          border: Border.all()
                        );
  }
}
