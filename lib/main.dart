import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/provider/login.dart';

import 'app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return Login();
          },
        )
      ],
      child: MaterialApp(
        home: App(),
      ),
    );
  }
}
