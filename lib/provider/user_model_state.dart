import 'dart:async';

import 'package:flutter/material.dart';

import '../model/user_model.dart';

class UserModelState extends ChangeNotifier{
  UserModel _userModel;
  StreamSubscription<UserModel> _currentStreamSub;

  UserModel get userModel => _userModel;

  set userModel(UserModel userModel){
    _userModel = userModel;
    notifyListeners();
  }

  set currentStreamSub(StreamSubscription<UserModel> currentStreamSub) => _currentStreamSub = currentStreamSub;

  clear() async {
    if(_currentStreamSub != null){
      await _currentStreamSub.cancel(); // cancel은 void 가 아닌 Future<void> 라는 것을 알아야 한다!!
      _currentStreamSub = null;
      _userModel = null;
    }
  }



//
//  bool amIFollowingThisUser(UserModel otherUser){
//    if(_userModel == null || _userModel.followings == null || _userModel.followings.isEmpty){
//      return false;
//    } else{
//      return _userModel.followings.contains(otherUser.userKey);
//    }
//  }
//
//  static bool isAFollowingB({@required UserModel a_userModel, @required UserModel b_userModel}){
//    if(a_userModel.followings == null || a_userModel.followings.isEmpty){
//      return false;
//    } else{
//      return a_userModel.followings.contains(b_userModel.userKey);
//    }
//  }

}