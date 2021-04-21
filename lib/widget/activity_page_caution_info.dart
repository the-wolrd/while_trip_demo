import 'package:flutter/material.dart';

import 'set_button.dart';

class ActivityPageCautionInfo extends StatefulWidget {

  final bool isSet;
  final String cautionInfo;

  ActivityPageCautionInfo({this.cautionInfo, this.isSet});

  @override
  _ActivityPageCautionInfoState createState() => _ActivityPageCautionInfoState();
}

class _ActivityPageCautionInfoState extends State<ActivityPageCautionInfo> {
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
                Text('유의사항'),
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
