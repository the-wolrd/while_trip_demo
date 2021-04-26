import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/provider/login_state_firebase.dart';
import 'package:while_trip_demo/provider/user_model_state.dart';
import 'package:while_trip_demo/screens/login/login_screen.dart';
import 'package:while_trip_demo/widget/while_progress_indicator.dart';

import 'network/network_function.dart';
import 'provider/gallery_state.dart';
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

        // 프로젝트 전체적으로 유저정보가 담긴 provider를 제공
        ChangeNotifierProvider<UserModelState>(create: (_)=>UserModelState()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.white
        ),
        home: Consumer<Login>(
          builder: (BuildContext context, Login loginStateProvider, Widget child) {

            switch(loginStateProvider.loginState){
              case LoginStatus.signIn:
                _initUserModel(loginStateProvider, context);
                _currentWidget = HomeScreen();
                break;

              case LoginStatus.signOut:
                _clearUserModel(context);
                _currentWidget = GetStartScreen();
                break;

              default:
                _currentWidget = Container();
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

  void _clearUserModel(BuildContext context) async {

    // for maintain user status after dispose
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    await prefs.setString(KEY_NOWUSERKEY, null);

    UserModelState userModelState = Provider.of<UserModelState>(context, listen: false);
    userModelState.clear();
  }


  void _initUserModel(Login login, BuildContext context) async {

    // for maintain user status after dispose
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    await prefs.setString(KEY_NOWUSERKEY, firebaseAuthState.user.uid);

    UserModelState userModelState = Provider.of<UserModelState>(context, listen: false);

    userModelState.currentStreamSub = networkFunction.getAUserModel(userKey: login.user.uid).listen((userModel){
      userModelState.userModel = userModel;
    });
  }

}
