import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/constant/constants.dart';
import 'package:while_trip_demo/network/network_function.dart';
import 'package:while_trip_demo/provider/login_state_firebase.dart';
import 'package:while_trip_demo/screens/home/home_screen.dart';
import 'package:while_trip_demo/screens/login/sub/sign_in_page.dart';
import 'package:while_trip_demo/screens/login/sub/sign_up_page.dart';

class LoginScreen extends StatelessWidget {
  final Function loginFunc;

  LoginScreen({this.loginFunc});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
            body: Column(
              children: [
                Spacer(
                  flex: 18,
                ),
                _logoImage(),
                Spacer(
                  flex: 24,
                ),
                _comment(),
                Spacer(
                  flex: 36,
                ),
                _bagImage(),
                Spacer(
                  flex: 23,
                ),
                _emailLoginButton(context),
                Spacer(
                  flex: 10,
                ),
                _anotherAccount(context),
                Spacer(
                  flex: 18,
                ),
                _signUpButton(context),
                Spacer(flex: 34),
              ],
            ),
          ),
    );
  }

  TextButton _signUpButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUp()),
        );
      },
      child: Text(
        '회원가입',
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w300),
      ),
    );
  }

  Padding _anotherAccount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Provider.of<Login>(context, listen: false).login_Kakao(context);
                },
                child: _imageIcon('assets/login_page/kakao_icon.png'),
              ),
              Spacer(
                flex: 1,
              ),
              InkWell(
                onTap: () {
                  Provider.of<Login>(context, listen: false).login_Facebook(context);
                },
                child: _imageIcon('assets/login_page/facebook_icon.png'),
              ),
              Spacer(
                flex: 1,
              ),
              InkWell(
                onTap: () {
                  Provider.of<Login>(context, listen: false).login_Google(context);
                },
                child: _imageIcon('assets/login_page/google_icon.png'),
              ),
              Spacer(
                flex: 1,
              ),
              InkWell(
                onTap: () {
                  Provider.of<Login>(context, listen: false).login_Apple(context);
                },
                child: _imageIcon('assets/login_page/apple_icon.png'),
              ),
            ],
          )
    );
  }

  Container _imageIcon(String path) {
    return Container(
      width: size.width / 6.2,
      height: size.width / 6.2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(path),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Padding _emailLoginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SizedBox(
        width: size.width,
        height: size.height / 11,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(113, 215, 219, 1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
            );
          },
          child: Center(
              child: Text(
            'email 로그인',
            style: TextStyle(color: Colors.white, fontSize: 15),
          )),
        ),
      ),
    );
  }

  Center _bagImage() {
    return Center(
      child: Container(
        width: size.width / 2,
        height: size.width / 1.8,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_page/login_image.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Text _comment() {
    return Text(
      '와일이 처음이신가요?\n와일과 함께\n나만의 여행계획을 세워보세요.',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.w100, color: Colors.black87),
    );
  }

  Center _logoImage() {
    return Center(
      child: Container(
        width: size.width / 4,
        height: size.width / 15,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_page/logo_icon.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
