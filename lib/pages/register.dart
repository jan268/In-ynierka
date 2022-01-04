import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:net_market/utilities/constants.dart';
import 'package:net_market/utilities/user_secure_storage.dart';

import 'home.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();
  final username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFA8EEE8),
                        Color(0xFF8DEFE8),
                        Color(0xFF4BE7E0),
                        Color(0xFF28EEDE),
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 120.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          _buildUsernameTF(),
                          SizedBox(height: 30.0),
                          _buildEmailTF(),
                          SizedBox(height: 30.0,),
                          _buildPasswordTF(),
                          SizedBox(height: 30.0,),
                          _buildRepeatPasswordTF(),
                          SizedBox(height: 30.0),
                          _buildRegisterBtn(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            autovalidate: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter username';
              }
              if(validateUsername(value)){
                return "Username is too long";
              }
              return null;
            },
            controller: username,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Enter your Username',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            autovalidate: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email';
              }
              if(!EmailValidator.validate(email.text)){
                return "Email is not valid";
              }
              return null;
            },
            controller: email,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  bool validateUsername(String username) {
    if(username.length < 30) {
      return false;
    }
    return true;
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            autovalidate: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              if(validateNewPassword(value)){
                return "Password is too weak";
              }
              return null;
            },
            controller: password,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock_open,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  bool validateNewPassword(String newPassword) {
    RegExp regExp = RegExp("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@%^&*-]).{8,}");
    if(regExp.hasMatch(newPassword)) {
      return false;
    }
    return true;
  }

  Widget _buildRepeatPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Repeat Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            autovalidate: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password again';
              }
              if(verifyPassword(value, password.text)){
                return "Password does not match";
              }
              return null;
            },
            controller: repeatPassword,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Confirm your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  bool verifyPassword(String password, String repeatPassword) {
    if (password == repeatPassword) {
      return false;
    }
    return true;
  }

  Future<void> registerAction() async {
    if (_formKey.currentState!.validate()) {
        Map<String, String> body = prepareBody();
        print(body);
        var response = await post(Uri.parse(
            "http://netmarket-api.eu-central-1.elasticbeanstalk.com/api/Identity/register"),
            headers: {
              "accept": "*/*",
              "Content-Type": "application/json"
            },
            body: json.encode(body),
            encoding: Encoding.getByName("utf-8"));
        if (response.statusCode == 200) {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Home(category: 'SNEAKERS',)));
          await UserSecureStorage.setJwt(response.body);
        } // tu trzeba zrobic obsluge tego, ze sie nie udalo zalogowac
    }
    // tu trzeba wywalic popup, ze bledne haslo
  }

  Map<String, String> prepareBody() {
     var body = {
      "email": "${email.text}",
      "userName": "${username.text}",
      "password": "${password.text}"
    };
    return body;
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => registerAction(), // tu robimy obsluge logowania
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Sign up',
          style: TextStyle(
            color: Color(0xFF8DEFE8),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
