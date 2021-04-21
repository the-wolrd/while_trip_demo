import 'package:flutter/material.dart';
import 'package:while_trip_demo/widget/set_button.dart';

class ActivityPageSpecificInfo extends StatefulWidget {

  final bool isSet;
  final String specificInfo;

  ActivityPageSpecificInfo({this.specificInfo, this.isSet});

  @override
  _ActivityPageSpecificInfoState createState() => _ActivityPageSpecificInfoState();
}

class _ActivityPageSpecificInfoState extends State<ActivityPageSpecificInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 30.0,
                  width: 3.0,
                  color: Colors.lightBlueAccent,
                ),
                Text('상세 정보'),
                Expanded(child: Container()),
                SetButton(
                    setFunc: (){}
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
