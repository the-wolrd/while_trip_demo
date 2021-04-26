import 'package:flutter/material.dart';
import 'package:while_trip_demo/model/user_model.dart';
import 'package:while_trip_demo/network/network_function.dart';

class BusinessTransferPage extends StatefulWidget {

  final UserModel user;

  BusinessTransferPage({this.user});

  @override
  _BusinessTransferPageState createState() => _BusinessTransferPageState();
}

class _BusinessTransferPageState extends State<BusinessTransferPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200.0,
            ),
            Text('비즈니스 계정으로 등록하시 겠습니까?'),
            SizedBox(
              height: 50.0,
            ),
            TextButton(
              onPressed: () async {
                await networkFunction.transferBusinessStatus(userKey: widget.user.userKey);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('비즈니스 <-> 일반 전환'),
            )

          ],
        ),
      ),
    );
  }
}
