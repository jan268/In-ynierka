
import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:net_market/objects/account_object.dart';
import 'package:net_market/objects/filter_object.dart';
import 'package:net_market/pages/search.dart';
import 'package:net_market/utilities/basic_icons_icons.dart';
import 'package:net_market/utilities/user_secure_storage.dart';

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
  bool status = false;

  @override
  Widget build(BuildContext context) {
    getEmailAddress();
    getProfileName();
    getPaypalEmail();
    getBillingAddress();
    getShippingAddress();
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                    height: 450,
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
    print(status);
    final _formKey = GlobalKey<FormState>();
    final email = TextEditingController(text: widget.email);
    final oldPassword = TextEditingController();
    final newPassword = TextEditingController();
    final confirmNewPassword = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Stack(
                children: [
                    SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Align(child: Text("Email"), alignment: Alignment.centerLeft,),
                            Container(
                              decoration: boxDecoration(),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter email';
                                  }
                                  if(!EmailValidator.validate(value)) {
                                    return "Address is not valid";
                                  }
                                  return null;
                                },
                                controller: email,
                              ),
                            ),
                            SizedBox(height: 30,),
                            Align(child: Text("Old Password"), alignment: Alignment.centerLeft,),
                            Container(
                              decoration: boxDecoration(),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter old password';
                                  }
                                  return null;
                                },
                                controller: oldPassword,
                              ),
                            ),
                            SizedBox(height: 30,),
                            Align(child: Text("New Password"), alignment: Alignment.centerLeft,),
                            Container(
                              decoration: boxDecoration(),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter new password';
                                  }
                                  if (validateNewPassword(value)) {
                                    return 'Password is Too Weak';
                                  }
                                  return null;
                                },
                                controller: newPassword,
                              ),
                            ),
                            SizedBox(height: 30,),
                            Align(child: Text("Confirm New Password"), alignment: Alignment.centerLeft,),
                            Container(
                              decoration: boxDecoration(),
                              child: TextFormField(
                                validator: (value) {
                                  print(value);
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter new password again';
                                  }
                                  if (validateConfirmNewPassword(value, newPassword.text)) {
                                    return 'Wrong password';
                                  }
                                  return null;
                                },
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
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      changePasswordRequest(email.text, oldPassword.text, newPassword.text);
                                    }
                                  },
                                  child: Text("Change Password"),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
          );
        }
    );
  }

  redNotification(String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.red[700],
            title: const Text('Oops'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(text),
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

  greenNotification(String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.green[400],
            title: const Text('Yaay'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(text),
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

  bool validateNewPassword(String newPassword) {
    RegExp regExp = RegExp("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@%^&*-]).{8,}");
      if(regExp.hasMatch(newPassword)) {
        return false;
      }
      return true;
  }

  bool validateConfirmNewPassword(String confirmNewPassword, String newPassword) {
    if(confirmNewPassword == newPassword) {
      return false;
    }
    return true;
  }

  profileResetForm() {
    final _formKey = GlobalKey<FormState>();
    final firstName = TextEditingController(text: accountObject.firstName);
    final lastName = TextEditingController(text: accountObject.lastName);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Align(child: Text("First Name"), alignment: Alignment.centerLeft,),
                        Container(
                          decoration: boxDecoration(),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter first name';
                              }
                              return null;
                            },
                            controller: firstName,
                          ),
                        ),
                        SizedBox(height: 30,),
                        Align(child: Text("Last Name"), alignment: Alignment.centerLeft,),
                        Container(
                          decoration: boxDecoration(),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter last name';
                              }
                              return null;
                            },
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  changeProfileRequest(firstName.text, lastName.text);
                                }
                              },
                              // onPressed: changePasswordButton ? () {
                              //   sendRequest();
                              // } : null,
                              child: Text("Change Profile Info"),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  billingResetForm() {
    final _formKey = GlobalKey<FormState>();
    final paypalEmail = TextEditingController(text: accountObject.paypalEmail);
    final street = TextEditingController(text: accountObject.billingStreet);
    final addressLine1 = TextEditingController(text: accountObject.billingAddressLine1);
    final addressLine2 = TextEditingController(text: accountObject.billingAddressLine2);
    final zipCode = TextEditingController(text: accountObject.billingZipCode);
    final country = TextEditingController(text: accountObject.billingCountry);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Align(child: Text("Paypal email"), alignment: Alignment.centerLeft,),
                        Container(
                          decoration: boxDecoration(),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              if(!EmailValidator.validate(value)) {
                                return "Address is not valid";
                              }
                              return null;
                            },
                            controller: paypalEmail,
                          ),
                        ),
                        SizedBox(height: 30,),
                        Align(child: Text("Street"), alignment: Alignment.centerLeft,),
                        Container(
                          decoration: boxDecoration(),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter street';
                              }
                              return null;
                            },
                            controller: street,
                          ),
                        ),
                        SizedBox(height: 30,),
                        Align(child: Text("Address line 1"), alignment: Alignment.centerLeft,),
                        Container(
                          decoration: boxDecoration(),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter address';
                              }
                              return null;
                            },
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
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter zip code';
                              }
                              if(validateZipCode(value)) {
                                return "Zip code does not match regex";
                              }
                              return null;
                            },
                            controller: zipCode,
                          ),
                        ),
                        SizedBox(height: 30,),
                        Align(child: Text("Country"), alignment: Alignment.centerLeft,),
                        Container(
                          decoration: boxDecoration(),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter country';
                              }
                              return null;
                            },
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  changeBillingRequest(paypalEmail.text, street.text,
                                      addressLine1.text, addressLine2.text,
                                      zipCode.text, country.text);
                                }
                              },
                              child: Text("Change Billing Info"),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  shippingResetForm() {
    final _formKey = GlobalKey<FormState>();
    final street = TextEditingController(text: accountObject.shippingStreet);
    final addressLine1 = TextEditingController(text: accountObject.shippingAddressLine1);
    final addressLine2 = TextEditingController(text: accountObject.shippingAddressLine2);
    final zipCode = TextEditingController(text: accountObject.shippingZipCode);
    final country = TextEditingController(text: accountObject.shippingCountry);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Align(child: Text("Street"), alignment: Alignment.centerLeft,),
                        Container(
                          decoration: boxDecoration(),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter street';
                              }
                              return null;
                            },
                            controller: street,
                          ),
                        ),
                        SizedBox(height: 30,),
                        Align(child: Text("Address line 1"), alignment: Alignment.centerLeft,),
                        Container(
                          decoration: boxDecoration(),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter address';
                              }
                              return null;
                            },
                            controller: addressLine1,
                          ),
                        ),
                        SizedBox(height: 30,),
                        Align(child: Text("Address line 2"), alignment: Alignment.centerLeft,),
                        Container(
                          decoration: boxDecoration(),
                          child: TextFormField(
                            controller: addressLine2,
                          ),
                        ),
                        SizedBox(height: 30,),
                        Align(child: Text("Zip code"), alignment: Alignment.centerLeft,),
                        Container(
                          decoration: boxDecoration(),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter zip code';
                              }
                              if(validateZipCode(value)) {
                                return "Zip code does not match regex";
                              }
                              return null;
                            },
                            controller: zipCode,
                          ),
                        ),
                        SizedBox(height: 30,),
                        Align(child: Text("Country"), alignment: Alignment.centerLeft,),
                        Container(
                          decoration: boxDecoration(),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter country';
                              }
                              return null;
                            },
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  changeShippingRequest(street.text,
                                      addressLine1.text, addressLine2.text,
                                      zipCode.text, country.text);
                                }
                              },
                              child: Text("Change Shipping Info"),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  bool validateZipCode(String zipCode) {
    if(zipCode.length == 5) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    AccountObject dataFromApi = await AccountObject.getAccount();
    setState(() {
      if(dataFromApi.firstName == null){
        dataFromApi.firstName = "";
      }
      if(dataFromApi.lastName == null){
        dataFromApi.lastName = "";
      }
      if(dataFromApi.paypalEmail == null){
        dataFromApi.paypalEmail = "";
      }
      if(dataFromApi.billingStreet == null){
        dataFromApi.billingStreet = "";
      }
      if(dataFromApi.billingAddressLine1 == null){
        dataFromApi.billingAddressLine1 = "";
      }
      if(dataFromApi.billingAddressLine2 == null){
        dataFromApi.billingAddressLine2 = "";
      }
      if(dataFromApi.billingZipCode == null){
        dataFromApi.billingZipCode = "";
      }
      if(dataFromApi.billingCountry == null){
        dataFromApi.billingCountry = "";
      }
      if(dataFromApi.shippingStreet == null){
        dataFromApi.shippingStreet = "";
      }
      if(dataFromApi.shippingAddressLine1 == null){
        dataFromApi.shippingAddressLine1 = "";
      }
      if(dataFromApi.shippingAddressLine2 == null){
        dataFromApi.shippingAddressLine2 = "";
      }
      if(dataFromApi.shippingZipCode == null){
        dataFromApi.shippingZipCode = "";
      }
      if(dataFromApi.shippingCountry == null){
        dataFromApi.shippingCountry = "";
      }
      accountObject = dataFromApi;
    });
  }

  Future<void> changeProfileRequest(String firstName, String lastName) async {
    String? token = await UserSecureStorage.getJwt();
    String jwt =  "Bearer " + token!.substring(token.lastIndexOf(':') + 2, token.length-2);
    var body = {
      "firstName": firstName,
      "lastName": lastName
    };
    var response = await put(Uri.parse(
        "http://netmarket-api.eu-central-1.elasticbeanstalk.com/api/User"),
        headers: {
          "Authorization": jwt,
          "accept": "*/*",
          "Content-Type": "application/json"
        },
        body: json.encode(body),
        encoding: Encoding.getByName("utf-8"));
    if(response.statusCode == 200) {
      Navigator.pop(context);
      getData();
      greenNotification("Successfully made changes");
    }else {
      Navigator.pop(context);
      redNotification(response.body.substring(response.body.lastIndexOf(":")+3, response.body.lastIndexOf("]")-1));
    }
  }

  Future<void> changeBillingRequest(String paypalEmail, String billingStreet,
                              String billingAddressLine1, String billingAddressLine2, String billingZipCode,
                              String billingCountry) async {
    String? token = await UserSecureStorage.getJwt();
    String jwt =  "Bearer " + token!.substring(token.lastIndexOf(':') + 2, token.length-2);
    var body = {
      "paypalEmail": paypalEmail,
      "billingStreet": billingStreet,
      "billingAddressLine1": billingAddressLine1,
      "billingAddressLine2": billingAddressLine2,
      "billingZipCode": billingZipCode,
      "billingCountry": billingCountry
    };
    var response = await put(Uri.parse(
        "http://netmarket-api.eu-central-1.elasticbeanstalk.com/api/User"),
        headers: {
          "Authorization": jwt,
          "accept": "*/*",
          "Content-Type": "application/json"
        },
        body: json.encode(body),
        encoding: Encoding.getByName("utf-8"));
    if(response.statusCode == 200) {
      Navigator.pop(context);
      getData();
      greenNotification("Successfully made changes");
    }else {
      Navigator.pop(context);
      redNotification(response.body.substring(response.body.lastIndexOf(":")+3, response.body.lastIndexOf("]")-1));
    }
  }

  Future<void> changeShippingRequest(String shippingStreet, String shippingAddressLine1,
      String shippingAddressLine2, String shippingZipCode, String shippingCountry) async {
    String? token = await UserSecureStorage.getJwt();
    String jwt =  "Bearer " + token!.substring(token.lastIndexOf(':') + 2, token.length-2);
    var body = {
      "shippingStreet": shippingStreet,
      "shippingAddressLine1": shippingAddressLine1,
      "shippingAddressLine2": shippingAddressLine2,
      "shippingZipCode": shippingZipCode,
      "shippingCountry": shippingCountry
    };
    var response = await put(Uri.parse(
        "http://netmarket-api.eu-central-1.elasticbeanstalk.com/api/User"),
        headers: {
          "Authorization": jwt,
          "accept": "*/*",
          "Content-Type": "application/json"
        },
        body: json.encode(body),
        encoding: Encoding.getByName("utf-8"));
    if(response.statusCode == 200) {
      Navigator.pop(context);
      getData();
      greenNotification("Successfully made changes");
    }else {
      Navigator.pop(context);
      redNotification(response.body.substring(response.body.lastIndexOf(":")+3, response.body.lastIndexOf("]")-1));
    }
  }

  Future<void> changePasswordRequest(String email, String password, String newPassword) async {
    String? token = await UserSecureStorage.getJwt();
    String jwt =  "Bearer " + token!.substring(token.lastIndexOf(':') + 2, token.length-2);
    var body = {
      "email": email,
      "password": password,
      "newPassword": newPassword
    };
    var response = await post(Uri.parse(
        "http://netmarket-api.eu-central-1.elasticbeanstalk.com/api/Identity/resetPassword"),
        headers: {
          "Authorization": jwt,
          "accept": "*/*",
          "Content-Type": "application/json"
        },
        body: json.encode(body),
        encoding: Encoding.getByName("utf-8"));
    print(response.body);
    if(response.statusCode == 200) {
      Navigator.pop(context);
      getData();
      greenNotification("Successfully changed password");
    }else {
      Navigator.pop(context);
      redNotification(response.body.substring(response.body.lastIndexOf(":")+3, response.body.lastIndexOf("]")-1));
    }
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
                          border: Border.all()
                        );
  }
}
