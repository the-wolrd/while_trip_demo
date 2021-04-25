
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:while_trip_demo/network/network_function.dart';
import 'package:while_trip_demo/constant/constants.dart';
import 'package:while_trip_demo/widget/while_progress_indicator.dart';

class Login extends ChangeNotifier{

  // 지금은 firebase 이지만, 나중에 바꿀때 같은 양식으로 따로 만들기 ㄲ

  LoginStatus _loginStatus = LoginStatus.signOut; // 지금은 테스트니깐 시작은 무조건 signOut
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _firebaseUser;

  LoginStatus get loginState => _loginStatus;
  User get user => _firebaseUser;

  void watchLoginChange(){
    _firebaseAuth.authStateChanges().listen((User firebaseUser){
      if(firebaseUser == null && _firebaseUser == null){
        return;
      }
      else if(firebaseUser != _firebaseUser){
        _firebaseUser = firebaseUser;
        changeLoginStatus();
      }
    });
  }

  void changeLoginStatus([LoginStatus loginStatus]){
    if(loginStatus != null){
      _loginStatus = loginStatus;
    } else {
      if(_firebaseUser != null){
        _loginStatus = LoginStatus.signIn;
      } else{
        _loginStatus = LoginStatus.signOut;
      }
    }
    notifyListeners();
  }

  void logOut() async {
    _loginStatus = LoginStatus.signOut;
    if(_firebaseUser != null){
      _firebaseUser = null;
      await _firebaseAuth.signOut();
    }
    notifyListeners();
  }


  void login_Email(BuildContext context, {@required String email, @required String password}) async {
    var flagError = false;
    User user;

    changeLoginStatus(LoginStatus.progress);

    showDialog(context: context, builder: (_){
      return WhileProgressIndicator();
    });

    try{
      var userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);
      user = userCredential.user;

    } on FirebaseAuthException catch (e){
      flagError = true;
      if (e.code == 'user-not-found'){
        print('No user found for that email');
      }else if (e.code == 'wrong-password'){
        print('Wrong password!');
      }
    }

    Navigator.pop(context); // showDialog 빠져나오기

    if (!flagError){

      Navigator.pop(context); // 로그인 화면 빠져나오기
      Navigator.pop(context); // 로그인 선택 빠져나오기

      _loginStatus = LoginStatus.signIn;
      _firebaseUser = user;
      notifyListeners();
    }
    else{
      await _showErrorDialog(context, '로그인 에러');

      changeLoginStatus(LoginStatus.signOut);
      notifyListeners();

      Navigator.pop(context); //showModelBottomSheet 빠져나오기
    }

  }

  void register_Email(BuildContext context, {@required String email, @required String password, @required Map<String, dynamic> userData}) async {

    changeLoginStatus(LoginStatus.progress);

    showDialog(context: context, builder: (_){
      return WhileProgressIndicator();
    });

    var _message = '회원가입 에러';

    var authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim())
        .catchError((error) {
      print('==== error occured ==== ${error.code}');
      switch (error.code) {
        case 'weak-password':
          _message = '패스워드 취약';
          break;
        case 'invalid-email':
          _message = '메일 주소가 이상합니다';
          break;
        case 'email-already-in-use':
          _message = '존재하는 이메일';
          break;
        case 'operation-not-allowed':
          _message = '옳지 않은 접근';
          break;
      }

    });

    Navigator.pop(context); // show dialog 빠져나오기.

    if (authResult == null) {

      await _showErrorDialog(context, _message);
      _firebaseUser = null;
      print('auth error : $_message');
      changeLoginStatus(LoginStatus.signOut);

      Navigator.pop(context); //showModelBottomSheet 빠져나오기

    } else {
      _showWaitPage(context, '회원가입 및 로그인 중');

      var finalUserData = userData;

      finalUserData[KEY_USERKEY] = authResult.user.uid; // userKey는 firebase auth 상에서 정해준다.
      await networkFunction.createUser(finalUserData);

      _firebaseUser = authResult.user;
      changeLoginStatus(LoginStatus.signIn);

      Navigator.pop(context); //showModelBottomSheet 빠져나오기
      Navigator.pop(context); // 회원가입 페이지
      Navigator.pop(context); // 로그인 선택 페이지
    }
  }


  // platform을 통한 로그인은 register 함수가 따로 필요하지 않을 수도 있다.
  // 자체적으로 돌아오는 값에 따라 login 인지, register인지 확인해야 할듯.

  void login_Facebook(BuildContext context){}
  void register_Facebook(BuildContext context){}

  void login_Kakao(BuildContext context){}
  void register_Kakao(BuildContext context){}

  void login_Google(BuildContext context){}
  void register_Google(BuildContext context){}

  void login_Apple(BuildContext context){}
  void register_Apple(BuildContext context){}



  void _showWaitPage(BuildContext context, String text){
    // await 넣으면 원하는 대로 작동 안됨. 로그인 완료가 되면 pop 해주기.
    showModalBottomSheet(
        context: context,
        builder: (_){
          return Center(child: Column(
            children: [
              Text(text),
              Text('잠시만 기다려 주세요')
            ],
          ));
        },
        isDismissible: false,
        enableDrag: false
    );
  }

  Future<void> _showErrorDialog(BuildContext context, String text) async {
    // await 넣으면 원하는 대로 작동 안됨. 에러가 생기면 내용을 1초 띄워준뒤 본화면으로 복귀.
    showModalBottomSheet(
        context: context,
        builder: (_){
          return SizedBox(
              height: size.height * 0.5,
              child: Center(child: Column(
                children: [
                  Text(text),
                  Text('1초뒤 닫힙니다')
                ],
              )));
        },
        isDismissible: false,
        enableDrag: false
    );
    await Future.delayed(Duration(seconds: 1), (){});
  }





}

enum LoginStatus {signIn, progress, signOut}