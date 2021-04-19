import 'package:flutter/material.dart';
import 'package:while_trip_demo/screens/login/login_screen.dart';
import 'package:while_trip_demo/constant/constants.dart';


double aa = size.width;

class GetStartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    if (size == null) {
      size = MediaQuery.of(context).size;
    }

    return SafeArea(
      child: Stack(
        children: [
          _backgroundImage(),
          _getStartButton(context),
        ],
      ),
    );
  }

  Column _getStartButton(BuildContext context) {
    return Column(
      children: [
        Spacer(flex: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: size.width,
            height: size.height / 11,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Center(
                  child: Text(
                '시작하기',
                style: TextStyle(color: Colors.cyan, fontSize: 17),
              )),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ),
        ),
        Spacer(flex: 1),
      ],
    );
  }

  Container _backgroundImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login_page/get_start.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
