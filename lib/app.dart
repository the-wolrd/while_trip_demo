import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/provider/login.dart';
import 'package:while_trip_demo/screens/login/login_screen.dart';

import 'constant/all/size.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/sub/get_start.dart';

class App extends StatelessWidget {


  Widget _currentWidget;

  @override
  Widget build(BuildContext context) {
    size ??= MediaQuery.of(context).size;
    return Consumer<Login>(
      builder: (BuildContext context, Login provider, Widget child) {

        switch(provider.loginState){
          case LoginState.signIn:
            _currentWidget = HomeScreen();
            print('로그인');
            break;

          case LoginState.signOut:
            _currentWidget = GetStartScreen();
            print('로그아웃');
            break;

          default:
            _currentWidget = CircularProgressIndicator();
            print('중');
            break;
        }
        return AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: _currentWidget);
      },
    );
  }
}
