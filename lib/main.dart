import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/provider/login.dart';

import 'app.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/sub/get_start.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application..

  Login _loginState = Login();
  Widget _currentWidget;

  @override
  Widget build(BuildContext context) {
    return
        ChangeNotifierProvider<Login>.value(
          value: _loginState,
          child:  MaterialApp(
            home: Consumer<Login>(
              builder: (BuildContext context, Login provider, Widget child) {

                switch(provider.loginState){
                  case LoginState.signIn:
                    _currentWidget = HomeScreen();
                    break;

                  case LoginState.signOut:
                    _currentWidget = GetStartScreen();
                    break;

                  default:
                    _currentWidget = CircularProgressIndicator();
                    break;
                }
                return AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: _currentWidget);

              },
            ),
          ),
        );
  }
}
