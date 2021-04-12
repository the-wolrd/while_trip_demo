import 'package:flutter/material.dart';

import 'constant/size.dart';
import 'screens/home/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(size == null){
      size = MediaQuery.of(context).size;
    }
    return HomeScreen();
  }
}
