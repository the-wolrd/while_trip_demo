
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends ChangeNotifier{
  bool _isLogin = false;
  get isLogin => _isLogin;

  LoginState _loginState = LoginState.signOut;
  LoginState get loginState => _loginState;

  void login(){
    _loginState = LoginState.signIn;
    print('바뀜!');
    notifyListeners();
  }

  void logout(){
    _loginState = LoginState.signOut;
    notifyListeners();
  }
}

enum LoginState{signIn, signOut}