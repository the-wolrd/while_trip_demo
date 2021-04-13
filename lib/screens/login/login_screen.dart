import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/constant/size.dart';
import 'package:while_trip_demo/provider/login.dart';
import 'package:while_trip_demo/screens/home/home_screen.dart';
import 'package:while_trip_demo/screens/login/sub/signUp.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Login>(
      builder: (BuildContext context, provider, Widget child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
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
      },
    );
  }

  TextButton _signUpButton(BuildContext context) {
    return TextButton(
      child: Text(
        "회원가입",
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w300),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUp()),
        );
      },
    );
  }

  Padding _anotherAccount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Consumer<Login>(
        builder: (BuildContext context, provider, Widget child) {

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: _imageIcon("assets/login_page/kakao_icon.png"),
                onTap: () {
                },
              ),
              Spacer(
                flex: 1,
              ),
              InkWell(
                child: _imageIcon("assets/login_page/facebook_icon.png"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
              Spacer(
                flex: 1,
              ),
              InkWell(
                child: _imageIcon("assets/login_page/google_icon.png"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
              Spacer(
                flex: 1,
              ),
              InkWell(
                child: _imageIcon("assets/login_page/apple_icon.png"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
            ],
          );
        },
      ),
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
          child: Center(
              child: Text(
            "email 로그인",
            style: TextStyle(color: Colors.white, fontSize: 15),
          )),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
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
            image: AssetImage("assets/login_page/login_image.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Text _comment() {
    return Text(
      "와일이 처음이신가요?\n와일과 함께\n나만의 여행계획을 세워보세요.",
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
            image: AssetImage("assets/login_page/logo_icon.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
