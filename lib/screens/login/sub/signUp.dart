import 'package:flutter/material.dart';
import 'package:while_trip_demo/constant/constants.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _logoImage(),
                _inputInfo(),
                TextFormField(
                  controller: _emailController,
                  cursorColor: Colors.black54,
                  decoration: textInputDecor('Email'),
                  validator: (text) {
                    if (text.isNotEmpty && text.contains("@")) {
                      return null;
                    } else {
                      return '정확한 이메일 주소를 입력해주세용~';
                    }
                  },
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _inputInfo() {
    return Text("정보를 입력해주세요.", textAlign: TextAlign.start,style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 23
            ),);
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

InputDecoration textInputDecor(String hint) {
  return InputDecoration(
      hintText: hint,
      enabledBorder: activeInputBorder(),
      focusedBorder: activeInputBorder(),
      errorBorder: errorInputBorder(),
      focusedErrorBorder: errorInputBorder(),
      filled: true,
      fillColor: Colors.grey[100]);
}

OutlineInputBorder errorInputBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.redAccent,
      ),
      borderRadius: BorderRadius.circular(7));
}

OutlineInputBorder activeInputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey[300],
    ),
    borderRadius: BorderRadius.circular(7),
  );
}
