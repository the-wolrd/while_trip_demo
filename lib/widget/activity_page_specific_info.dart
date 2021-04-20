import 'package:flutter/material.dart';

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
                Container(
                  height: 30.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Colors.grey,
                  ),
                  child: Center(child: Text('편집',style: TextStyle(color: Colors.white),)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
