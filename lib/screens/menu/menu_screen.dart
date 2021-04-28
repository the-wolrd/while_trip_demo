import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:while_trip_demo/constant/constants.dart';
import 'package:while_trip_demo/model/user_model.dart';
import 'package:while_trip_demo/provider/user_model_state.dart';
import 'package:while_trip_demo/screens/menu/sub/privacy_policy.dart';
import 'package:while_trip_demo/widget/my_history.dart';
import 'package:while_trip_demo/widget/my_activity.dart';
import 'package:while_trip_demo/widget/my_favorite.dart';
import 'package:while_trip_demo/widget/my_reviews.dart';

import 'sub/1vs1.dart';
import 'sub/personal_auth.dart';

class MenuScreen extends StatefulWidget {

  final UserModel user;

  MenuScreen({this.user});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

enum PerAlert { Allowed, NotAllowed }
enum PerLocate { Allowed, NotAllowed, UseApp }
enum MyTheme { Default, Dark }

class _MenuScreenState extends State<MenuScreen> {
  PerAlert _perAlert = PerAlert.Allowed;
  PerLocate _perLocate = PerLocate.Allowed;
  MyTheme _myTheme = MyTheme.Default;
  String _alertState = '허용';
  String _locateState = '허용';
  String _themeState = '기본';

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
            _userCard(),
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
          ],
        ),
      )),
    );
  }

  SizedBox _gap(int gap) => SizedBox(height: size.width / gap);

  InkWell _inquire() {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => QnA()));
      },
      child: const SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('1:1 문의하기'),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          )),
    );
  }

  Text _qnA() => Text(
        'Q&A',
        style: TextStyle(fontSize: 16, color: Colors.black38),
      );

  InkWell _licenceInfo() {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {},
      child: SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("라이센스 정보"),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          )),
    );
  }

  InkWell _serviceInfo() {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {},
      child: SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('서비스 이용 약관'),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          )),
    );
  }

  Text _etcInfo() => Text(
        '기타 정보',
        style: TextStyle(fontSize: 16, color: Colors.black38),
      );

  InkWell _privacy() {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));
      },
      child: const SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('개인정보 처리 방침'),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          )),
    );
  }

  InkWell _setTheme() {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        showDialog(
            context: context,
            //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                //Dialog Main Title
                title: Column(
                  children: <Widget>[
                    Text('알림 설정'),
                  ],
                ),
                //
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RadioListTile(
                      title: Text('기본'),
                      value: MyTheme.Default,
                      groupValue: _myTheme,
                      onChanged: (value) {
                        setState(() {
                          _myTheme = value;
                          print(value);
                          _themeState = '기본';
                          Navigator.pop(context);
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('다크'),
                      value: MyTheme.Dark,
                      groupValue: _myTheme,
                      onChanged: (value) {
                        setState(() {
                          _myTheme = value;
                          print(value);
                          _themeState = '다크';
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '취소',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              );
            });
      },
      child: const SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.video_label_rounded),
            title: Text('테마 설정'),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          )),
    );
  }

  InkWell _perLocation() {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        showDialog(
            context: context,
            //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                //Dialog Main Title
                title: Column(
                  children: <Widget>[
                    Text("알림 설정"),
                  ],
                ),
                //
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RadioListTile(
                      title: Text('항상'),
                      value: PerLocate.Allowed,
                      groupValue: _perLocate,
                      onChanged: (value) {
                        setState(() {
                          _perLocate = value;
                          print(value);
                          _locateState = "항상";
                          Navigator.pop(context);
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('앱을 사용하는동안'),
                      value: PerLocate.UseApp,
                      groupValue: _perLocate,
                      onChanged: (value) {
                        setState(() {
                          _perLocate = value;
                          print(value);
                          _locateState = "앱을 사용하는동안";
                          Navigator.pop(context);
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('안 허용'),
                      value: PerLocate.NotAllowed,
                      groupValue: _perLocate,
                      onChanged: (value) {
                        setState(() {
                          _perLocate = value;
                          print(value);
                          _locateState = "안 허용";
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '취소',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              );
            });
      },
      child: SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.not_listed_location),
            title: Text("위치 정보 수집"),
            trailing: Text(
              _locateState,
              style: TextStyle(color: Colors.black38),
            ),
          )),
    );
  }

  InkWell _setAlert() {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        showDialog(
            context: context,
            //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                //Dialog Main Title
                title: Column(
                  children: <Widget>[
                    const Text('알림 설정'),
                  ],
                ),
                //
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RadioListTile(
                      title: Text('허용'),
                      value: PerAlert.Allowed,
                      groupValue: _perAlert,
                      onChanged: (value) {
                        setState(() {
                          _perAlert = value;
                          print(value);
                          Navigator.pop(context);
                          _alertState = '허용';
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('안 허용'),
                      value: PerAlert.NotAllowed,
                      groupValue: _perAlert,
                      onChanged: (value) {
                        setState(() {
                          _perAlert = value;
                          print(value);
                          Navigator.pop(context);
                          _alertState = '안 허용';
                        });
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '취소',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              );
            });
      },
      child: SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.add_alert),
            title: Text('알림'),
            trailing: Text(
              _alertState,
              style: TextStyle(color: Colors.black38),
            ),
          )),
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
      onTap: () {
        showDialog(
            context: context,
            //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                //Dialog Main Title
                title: Column(
                  children: <Widget>[
                    Text('버전 정보'),
                  ],
                ),
                //
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '0.011(beta)',
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '확인',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              );
            });
      },
      child: SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('버전 정보'),
            trailing: Text(
              '최신 버전',
              style: TextStyle(color: Colors.black38),
            ),
          )),
    );
  }

  Text _application() {
    return Text(
      '어플리케이션',
      style: TextStyle(fontSize: 16, color: Colors.black38),
    );
  }

  Widget _userCard(){
    return Consumer<UserModelState>(
      builder: (context, userModelState, _){
        if (userModelState == null || userModelState.userModel == null){
          return Container();
        }
        else{
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: (userModelState.userModel.isBusiness)?Colors.lightBlueAccent:Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  _account(userModelState.userModel),
                  _gap(22),
                  _etc(userModelState.userModel)
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _etc(UserModel user) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color:Colors.grey[50]
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Spacer(flex: 1),

            user.isBusiness?
              SizedBox(
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context)=> MyActivityScreen(user: widget.user,)));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.work,
                        color: Colors.cyan,
                      ),
                      Text('액티비티\n관리', style: TextStyle(fontSize: 12), textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ):Container(),

            user.isBusiness?
              Spacer(flex: 2):Container(),

            SizedBox(
              child: InkWell(
                splashColor: Colors.grey,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHistoryScreen(user: user,)));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list_alt,
                      color: Colors.cyan,
                    ),
                    Text('이용내역', style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
            ),
            Spacer(flex: 2),
            InkWell(
              splashColor: Colors.grey,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyReviewScreen(user: user,)));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.chat,
                    color: Colors.cyan,
                  ),
                  Text('리뷰관리', style: TextStyle(fontSize: 12))
                ],
              ),
            ),
            Spacer(flex: 2),
            InkWell(
              splashColor: Colors.grey,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyFavoriteScreen(user: user,)));
                },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_border,
                    color: Colors.cyan,
                  ),
                  Text('관심목록', style: TextStyle(fontSize: 12))
                ],
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  Widget _account(UserModel user) {
    return Row(
            children: [
              Spacer(flex: 6),
              SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.profileImg),
                ),
              ),
              Spacer(flex: 11),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${user.userNickname}님',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 21, color: user.isBusiness?Colors.white:Colors.black)),
                SizedBox(height: 4),
                (user.isBusiness)?
                Text('비즈니스 회원', style: TextStyle(color: Colors.white),)
                    :Text('일반 회원', style: TextStyle(color: Colors.black)),
              ]),
              Spacer(flex: 88),
              IconButton(
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                  color: user.isBusiness?Colors.white:Colors.black,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => PersonalAuth(userModel: user)));
                  })
            ],
          );
  }

  Text _basicInfo() {
    return Text(
      '기본 정보',
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
          '더보기',
          style: TextStyle(fontSize: 18),
        ),
        Spacer(flex: 4),
      ],
    );
  }
}
