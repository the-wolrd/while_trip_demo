import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/constant/size.dart';
import 'package:while_trip_demo/provider/login.dart';

import 'sub/1vs1.dart';
import 'sub/personal_auth.dart';

class MenuScreen extends StatefulWidget {


  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: ListView(
                children: [
                  _topBar(context),
                  _gap(34),
                  _basicInfo(),
                  _gap(14),
                  _account(),
                  _gap(22),
                  _etc(),
                  _gap(18),
                  _application(),
                  _versionInfo(),
                  _myDivider(),
                  _setAlert(),
                  _myDivider(),
                  _perLocation(),
                  _myDivider(),
                  _setTheme(),
                  _myDivider(),
                  _gap(38),
                  _etcInfo(),
                  _privacy(),
                  _myDivider(),
                  _serviceInfo(),
                  _myDivider(),
                  _licenceInfo(),
                  _myDivider(),
                  _gap(38),
                  _qnA(),
                  _inquire(),
                  _myDivider(),
                  _gap(38),
                  TextButton(onPressed: (){
                    Provider.of<Login>(context, listen: false).logout();
                  },
                  child: Text("dsadsa"),
                  )
                ],
              ),
            )
      ),
    );
  }

  SizedBox _gap(int gap) => SizedBox(height: size.width / gap);

  InkWell _inquire() {
    return InkWell(
      splashColor: Colors.grey,
      child: SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.help_outline),
            title: Text("1:1 문의하기"),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          )),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => QnA()));
      },
    );
  }

  Text _qnA() => Text(
        "Q&A",
        style: TextStyle(fontSize: 16, color: Colors.black38),
      );

  InkWell _licenceInfo() {
    return InkWell(
      splashColor: Colors.grey,
      child: SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("라이센스 정보"),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          )),
      onTap: () {},
    );
  }

  InkWell _serviceInfo() {
    return InkWell(
      splashColor: Colors.grey,
      child: SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("서비스 이용 약관"),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          )),
      onTap: () {},
    );
  }

  Text _etcInfo() => Text(
        "기타 정보",
        style: TextStyle(fontSize: 16, color: Colors.black38),
      );

  InkWell _privacy() {
    return InkWell(
      splashColor: Colors.grey,
      child: SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("개인정보 처리 방침"),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          )),
      onTap: () {},
    );
  }

  InkWell _setTheme() {
    return InkWell(
      splashColor: Colors.grey,
      child: SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.video_label_rounded),
            title: Text("테마 설정"),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          )),
      onTap: () {},
    );
  }

  InkWell _perLocation() {
    return InkWell(
      splashColor: Colors.grey,
      child: SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.not_listed_location),
            title: Text("위치 정보 수집"),
            trailing: Text(
              '앱을 사용하는 동안',
              style: TextStyle(color: Colors.black38),
            ),
          )),
      onTap: () {},
    );
  }

  InkWell _setAlert() {
    return InkWell(
      splashColor: Colors.grey,
      child: SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.add_alert),
            title: Text("알림"),
            trailing: Text(
              '허용',
              style: TextStyle(color: Colors.black38),
            ),
          )),
      onTap: () {},
    );
  }

  Divider _myDivider() {
    return Divider(
      thickness: 1,
      color: Colors.black12,
      height: 1,
    );
  }

  InkWell _versionInfo() {
    return InkWell(
      splashColor: Colors.grey,
      child: SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("버전 정보"),
            trailing: Text(
              '최신 버전',
              style: TextStyle(color: Colors.black38),
            ),
          )),
      onTap: () {},
    );
  }

  Text _application() {
    return Text(
      "어플리케이션",
      style: TextStyle(fontSize: 16, color: Colors.black38),
    );
  }

  Row _etc() {
    return Row(
      children: [
        Spacer(flex: 1),
        SizedBox(
          child: InkWell(
            splashColor: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.list_alt),
                Text("이용내역", style: TextStyle(fontSize: 12))
              ],
            ),
            onTap: () {},
          ),
        ),
        Spacer(flex: 2),
        InkWell(
          splashColor: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.chat),
              Text("리뷰관리", style: TextStyle(fontSize: 12))
            ],
          ),
          onTap: () {},
        ),
        Spacer(flex: 2),
        InkWell(
          splashColor: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star_border),
              Text("관심목록", style: TextStyle(fontSize: 12))
            ],
          ),
          onTap: () {},
        ),
        Spacer(flex: 1),
      ],
    );
  }

  Row _account() {
    return Row(
      children: [
        Spacer(flex: 6),
        Icon(
          Icons.account_circle,
          size: 60,
          color: Colors.grey,
        ),
        Spacer(flex: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("김다슬님",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 21)),
          SizedBox(height: 4),
          Text("일반 회원"),
        ]),
        Spacer(flex: 88),
        IconButton(
            icon: Icon(Icons.arrow_forward_ios_rounded), onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PersonalAuth()));
        })
      ],
    );
  }

  Text _basicInfo() {
    return Text(
      "기본 정보",
      style: TextStyle(fontSize: 15, color: Colors.black38),
    );
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
          "더보기",
          style: TextStyle(fontSize: 18),
        ),
        Spacer(flex: 4),
      ],
    );
  }
}
