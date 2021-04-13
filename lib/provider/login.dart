import 'package:flutter/foundation.dart';

class Login extends ChangeNotifier{
  bool _isLogin = false;
  get isLogin => _isLogin;
  LoginState _loginState = LoginState.signOut;
  LoginState get loginState => _loginState;


  void login(){
    _loginState = LoginState.signIn;
    notifyListeners();
  }
  void logout(){
    _loginState = LoginState.signOut;
    notifyListeners();
  }
}

enum LoginState{signIn, signOut}