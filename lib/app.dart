import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/provider/login.dart';
import 'package:while_trip_demo/screens/login/login_screen.dart';

import 'constant/size.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/sub/get_start.dart';

class App extends StatelessWidget {
  @override

  Widget _currentWidget;

  Widget build(BuildContext context) {
    if (size == null) {
      size = MediaQuery.of(context).size;
    }
    return Consumer<Login>(
      builder: (BuildContext context, provider, Widget child) {

        switch(provider.loginState){
          case LoginState.signIn:
            _currentWidget = HomeScreen();
            break;
          case LoginState.signOut:
            _currentWidget = GetStartScreen();
        }
        return _currentWidget;
      },
    );
  }
}
