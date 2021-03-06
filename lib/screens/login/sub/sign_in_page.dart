import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/constant/constants.dart';
import 'package:while_trip_demo/provider/login_state_firebase.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  void initState() {
    _emailController.text = 'aaaa@aaaa.aaaa';
    _pwController.text = 'aaaaaa';
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _gap(20.0),
                  _logoImage(),
                  _gap(20.0),
                  _inputInfo(),
                  _gap(20.0),
                  _emailForm(),
                  _gap(20.0),
                  _passwordForm(),
                  _gap(30.0),
                  _submitButton(context),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _gap(double gap) => SizedBox(height: gap);

  Widget _submitButton(BuildContext context) {

    return InkWell(
      onTap: (){
        if(_formKey.currentState.validate()){
          Provider.of<Login>(context, listen:false).login_Email(context, email: _emailController.text, password: _pwController.text);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius : BorderRadius.circular(10.0),
            color: Colors.lightBlueAccent
        ),
        child: Center(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal:50.0),
          child: Text('?????????',style: TextStyle(color: Colors.white),),
        )),
      ),
    );
  }

  TextFormField _passwordForm() {
    return TextFormField(
      controller: _pwController,
      cursorColor: Colors.black54,
      decoration: textInputDecor('????????????'),
      obscureText: true,
      validator: (text) {
        if (text.isNotEmpty && text.length >= 6) {
          return null;
        } else {
          return '??????????????? 6??? ??????????????? ?????????.';
        }
      },
    );
  }

  TextFormField _emailForm() {
    return TextFormField(
      controller: _emailController,
      cursorColor: Colors.black54,
      decoration: textInputDecor('?????????'),
      validator: (text) {
        if (text.isNotEmpty && text.contains('@')) {
          return null;
        } else {
          return '????????? ????????? ????????? ??????????????????~';
        }
      },
    );
  }


  Widget _inputInfo() {
    return Text('?????????', textAlign: TextAlign.start,style: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 23
    ),);
  }

  Widget _logoImage() {
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
