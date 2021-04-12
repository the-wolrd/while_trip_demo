import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/provider/login.dart';
import 'package:while_trip_demo/screens/login/login_screen.dart';

import 'constant/size.dart';
import 'screens/home/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (size == null) {
      size = MediaQuery.of(context).size;
    }
    return Consumer<Login>(
      builder: (BuildContext context, provider, Widget child) {
        if (provider.isLogin){
          return HomeScreen();
        }else{
          return LoginScreen();
        }
      },
    );
  }
}
