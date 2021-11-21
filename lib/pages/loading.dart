
import 'package:flutter/material.dart';
import 'package:net_market/mocks/mocked_lists.dart';
import 'package:net_market/pages/login_screen.dart';
import 'package:net_market/utilities/user_secure_storage.dart';

import 'home.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void loadUser() async {
    String token = await UserSecureStorage.getJwt() as String;
    if (token != '') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(category: 'SNEAKERS',)));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    //tu bedzie zaciaganie usera
    //tu bedzie if (ze jesli juz zalogowany to /home, jak nie to login_screen
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return MockedLists.loadingWidget();
  }

}
