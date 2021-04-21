import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/provider/login.dart';

import 'model/gallery_state.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/sub/get_start.dart';
import 'test1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application..

  final GalleryState _galleryState = GalleryState();

  @override
  _MyAppState createState() {
    _galleryState.initProvider();
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final Login _loginState = Login();

  Widget _currentWidget;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Login>.value(value: _loginState),
        ChangeNotifierProvider<GalleryState>.value(value: widget._galleryState),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.white
        ),
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
