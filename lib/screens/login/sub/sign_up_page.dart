import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/constant/constants.dart';
import 'package:while_trip_demo/provider/login_state_firebase.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();

  @override
  void initState() {
    _emailController.text = 'aaaa@aaaa.aaaa';
    _pwController.text = 'aaaaaa';
    _pwConfirmController.text = 'aaaaaa';
    _nickNameController.text = 'aaaaaa';
    _infoController.text = 'aaaaaa';
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _pwConfirmController.dispose();
    _nickNameController.dispose();
    _infoController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
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
                  _gap(20.0),
                  _passwordConfirmForm(),
                  _gap(20.0),
                  _nickNameForm(),
                  _gap(20.0),
                  _infoForm(),
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
          Provider.of<Login>(context, listen:false).register_Email(context, email: _emailController.text, password: _pwController.text, userData: {
            KEY_USERKEY : '', // firebase auth 쪽에서 자동 생성 될것임.
            KEY_LOGINTYPE : LOGIN_TYPE_EMAIL,
            KEY_USEREMAIL : _emailController.text,
            KEY_USERNICKNAME : _nickNameController.text,
            KEY_USERINFO : _infoController.text,
            KEY_PROFILEIMG : 'https://picsum.photos/200',
            KEY_ISBUSINESS : false,
            KEY_USERLOCATIONS : [{'title': '집', 'address': '대전 유성구 대학로 291', 'detail': 'w5-2 스타트업빌리지 204호', 'lat': 36.3693545, 'lon':127.355723}],
            KEY_RANGE : 5000,
            KEY_ACTIVITIES : [],
            KEY_FAVORITES : [],
            KEY_MYREVIEWS : [],
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius : BorderRadius.circular(10.0),
          color: Colors.lightBlueAccent
        ),
        child: Center(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal:50.0),
          child: Text('회원가입 신청',style: TextStyle(color: Colors.white),),
        )),
      ),
    );
  }

  TextFormField _nickNameForm() {
    return TextFormField(
      controller: _nickNameController,
      cursorColor: Colors.black54,
      decoration: textInputDecor('닉네임'),
      validator: (text) {
        if (text.isNotEmpty) {
          return null;
        } else {
          return '닉네임을 적어주세요.';
        }
      },
    );
  }

  TextFormField _infoForm() {
    return TextFormField(
                controller: _infoController,
                cursorColor: Colors.black54,
                decoration: textInputDecor('상태메세지'),
                validator: (text) {
                  if (text.isNotEmpty) {
                    return null;
                  } else {
                    return '상태 메세지를 적어주세요.';
                  }
                },
              );
  }


  TextFormField _passwordConfirmForm() {
    return TextFormField(
                controller: _pwConfirmController,
                cursorColor: Colors.black54,
                decoration: textInputDecor('패스워드 재확인'),
                obscureText: true,
                validator: (text) {
                  if (text == _pwController.text) {
                    return null;
                  } else {
                    return '패스워드가 다릅니다.';
                  }
                },
              );
  }

  TextFormField _passwordForm() {
    return TextFormField(
                controller: _pwController,
                cursorColor: Colors.black54,
                decoration: textInputDecor('패스워드'),
                  obscureText: true,
                validator: (text) {
                  if (text.isNotEmpty && text.length >= 6) {
                    return null;
                  } else {
                    return '패스워드는 6자 이상이어야 합니다.';
                  }
                },
              );
  }

  TextFormField _emailForm() {
    return TextFormField(
                controller: _emailController,
                cursorColor: Colors.black54,
                decoration: textInputDecor('이메일'),
                validator: (text) {
                  if (text.isNotEmpty && text.contains('@')) {
                    return null;
                  } else {
                    return '정확한 이메일 주소를 입력해주세용~';
                  }
                },
              );
  }


  Widget _inputInfo() {
    return Text('회원가입', textAlign: TextAlign.start,style: TextStyle(
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
