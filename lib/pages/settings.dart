
import 'package:flutter/material.dart';
import 'package:net_market/objects/account_object.dart';
import 'package:net_market/objects/filter_object.dart';
import 'package:net_market/pages/search.dart';
import 'package:net_market/utilities/basic_icons_icons.dart';

import 'home.dart';

class SettingsPage extends StatefulWidget {
  final String email;
  const SettingsPage({Key? key, required this.email}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  AccountObject accountObject = AccountObject();
  String profileName = "Not provided";
  String emailAddress = "Not provided";
  String paypalEmail = "Not provided";
  String billingAddress = "Not provided";
  String shippingAddress = "Not provided";
  bool changePasswordButton = false;

  @override
  Widget build(BuildContext context) {
    getEmailAddress();
    getProfileName();
    getPaypalEmail();
    getBillingAddress();
    getShippingAddress();
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
                                        onPressed: () {
                                          profileResetForm();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                        passwordResetForm();
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
                                        onPressed: () {
                                          billingResetForm();
                                        },
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
                                              shippingAddress
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          shippingResetForm();
                                        },
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

  void getProfileName() {
    if(accountObject.firstName == null || accountObject.lastName == null) {
        return;
    }
    String displayName = accountObject.firstName! + " " + accountObject.lastName!;
    profileName = displayName;
  }

  void getEmailAddress() {
    emailAddress = widget.email;
  }

  void getPaypalEmail() {
    if(accountObject.paypalEmail == null) {
      return;
    }
    String displayName = accountObject.paypalEmail!;
    paypalEmail = displayName;
  }

  void getBillingAddress() {
    if(accountObject.billingStreet == null || accountObject.billingAddressLine1 == null
        || accountObject.billingZipCode == null || accountObject.billingCountry == null) {
      return;
    }
    String displayName = accountObject.billingStreet! + "\n" +
        accountObject.billingAddressLine1! + "\n" +
        accountObject.billingAddressLine2! + "\n" +
        accountObject.billingZipCode! + "\n" +
        accountObject.billingCountry!;
    billingAddress = displayName;
  }

  void getShippingAddress() {
    if(accountObject.shippingStreet == null || accountObject.shippingAddressLine1 == null
        || accountObject.shippingZipCode == null || accountObject.shippingCountry == null) {
      return;
    }
    String displayName = accountObject.shippingStreet! + "\n" +
        accountObject.shippingAddressLine1! + "\n" +
        accountObject.shippingAddressLine2! + "\n" +
        accountObject.shippingZipCode! + "\n" +
        accountObject.shippingCountry!;
    shippingAddress = displayName;
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

  passwordResetForm() {
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
                        SizedBox(height: 50,),
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

  profileResetForm() {
    final firstName = TextEditingController();
    final lastName = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              children: [
                Column(
                  children: [
                    Align(child: Text("First Name"), alignment: Alignment.centerLeft,),
                    Container(
                      decoration: boxDecoration(),
                      child: TextField(
                        controller: firstName,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Align(child: Text("Last Name"), alignment: Alignment.centerLeft,),
                    Container(
                      decoration: boxDecoration(),
                      child: TextField(
                        controller: lastName,
                      ),
                    ),
                    SizedBox(height: 50,),
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

  billingResetForm() {
    final paypalEmail = TextEditingController();
    final street = TextEditingController();
    final addressLine1 = TextEditingController();
    final addressLine2 = TextEditingController();
    final zipCode = TextEditingController();
    final country = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(child: Text("Paypal email"), alignment: Alignment.centerLeft,),
                      Container(
                        decoration: boxDecoration(),
                        child: TextField(
                          controller: paypalEmail,
                        ),
                      ),
                      SizedBox(height: 30,),
                      Align(child: Text("Street"), alignment: Alignment.centerLeft,),
                      Container(
                        decoration: boxDecoration(),
                        child: TextField(
                          controller: street,
                        ),
                      ),
                      SizedBox(height: 30,),
                      Align(child: Text("Address line 1"), alignment: Alignment.centerLeft,),
                      Container(
                        decoration: boxDecoration(),
                        child: TextField(
                          controller: addressLine1,
                        ),
                      ),
                      SizedBox(height: 30,),
                      Align(child: Text("Address line 2"), alignment: Alignment.centerLeft,),
                      Container(
                        decoration: boxDecoration(),
                        child: TextField(
                          controller: addressLine2,
                        ),
                      ),
                      SizedBox(height: 30,),
                      Align(child: Text("Zip code"), alignment: Alignment.centerLeft,),
                      Container(
                        decoration: boxDecoration(),
                        child: TextField(
                          controller: zipCode,
                        ),
                      ),
                      SizedBox(height: 30,),
                      Align(child: Text("Country"), alignment: Alignment.centerLeft,),
                      Container(
                        decoration: boxDecoration(),
                        child: TextField(
                          controller: country,
                        ),
                      ),
                      SizedBox(height: 50,),
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
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  shippingResetForm() {
    final street = TextEditingController();
    final addressLine1 = TextEditingController();
    final addressLine2 = TextEditingController();
    final zipCode = TextEditingController();
    final country = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              children: [
                Column(
                  children: [
                    Align(child: Text("Street"), alignment: Alignment.centerLeft,),
                    Container(
                      decoration: boxDecoration(),
                      child: TextField(
                        controller: street,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Align(child: Text("Address line 1"), alignment: Alignment.centerLeft,),
                    Container(
                      decoration: boxDecoration(),
                      child: TextField(
                        controller: addressLine1,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Align(child: Text("Address line 2"), alignment: Alignment.centerLeft,),
                    Container(
                      decoration: boxDecoration(),
                      child: TextField(
                        controller: addressLine2,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Align(child: Text("Zip code"), alignment: Alignment.centerLeft,),
                    Container(
                      decoration: boxDecoration(),
                      child: TextField(
                        controller: zipCode,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Align(child: Text("Country"), alignment: Alignment.centerLeft,),
                    Container(
                      decoration: boxDecoration(),
                      child: TextField(
                        controller: country,
                      ),
                    ),
                    SizedBox(height: 50,),
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
    getData();
    // email.addListener(() {
    //   final changePassword = email.text.isNotEmpty;
    //   setState(() {
    //     this.changePasswordButton = changePassword;
    //   });
    // });
  }

  Future<void> getData() async {
    AccountObject dataFromApi = await AccountObject.getAccount();
    setState(() {
      accountObject = dataFromApi;
    });
  }

  sendRequest() {

  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
                          border: Border.all()
                        );
  }
}
