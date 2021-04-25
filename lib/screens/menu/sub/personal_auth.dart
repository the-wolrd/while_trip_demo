import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/provider/login_state_firebase.dart';
import 'package:while_trip_demo/constant/constants.dart';

class PersonalAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ListView(
        children: [
          _topBar(context),
          _gap(39),
          Text(
            "계정",
            style: TextStyle(fontSize: 12, color: Colors.black38),
          ),
          ListTile(
            leading: Text(
              "이메일",
              style: TextStyle(fontSize: 18),
            ),
            trailing: Text(
              "google@gmail.com",
              style: TextStyle(color: Colors.black38),
            ),
          ),
          _myDivider(),
          ListTile(
            leading: Text(
              "닉네임",
              style: TextStyle(fontSize: 18),
            ),
            trailing: Text(
              "김다슬",
              style: TextStyle(color: Colors.black38),
            ),
          ),
          _myDivider(),
          _gap(39),
          Text(
            "개인 정보",
            style: TextStyle(fontSize: 12, color: Colors.black38),
          ),
          InkWell(
            splashColor: Colors.grey,
            child: ListTile(
              leading: Text(
                "개인 정보",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.arrow_forward_ios_outlined)
            ),
            onTap: (){},
          ),
          _myDivider(),
          InkWell(
            splashColor: Colors.grey,
            child: ListTile(
                leading: Text(
                  "비지니스 계정으로 전환",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined)
            ),
            onTap: (){},
          ),
          _myDivider(),
          _gap(39),
          Text(
            "기타",
            style: TextStyle(fontSize: 12, color: Colors.black38),
          ),
          InkWell(
            splashColor: Colors.grey,
            child: ListTile(
                leading: Text(
                  "데이터 초기화",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined)
            ),
            onTap: (){},
          ),
          _myDivider(),
          InkWell(
            splashColor: Colors.grey,
            child: ListTile(
                leading: Text(
                  "로그아웃",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined)
            ),
            onTap: (){
              Navigator.pop(context);
              Navigator.pop(context);
              Provider.of<Login>(context, listen: false).logOut();
            },
          ),
          _myDivider(),
          InkWell(
            splashColor: Colors.grey,
            child: ListTile(
                leading: Text(
                  "회원 탈퇴",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined)
            ),
            onTap: (){},
          ),
          _myDivider(),
        ],
      ),
    ));
  }

  Row _topBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        Spacer(flex: 3),
        Text(
          "계정",
          style: TextStyle(fontSize: 18),
        ),
        Spacer(flex: 4),
      ],
    );
  }
  Divider _myDivider() {
    return Divider(
      thickness: 1,
      color: Colors.black12,
      height: 1,
    );
  }
  SizedBox _gap(int gap) => SizedBox(height: size.width / gap);
}
