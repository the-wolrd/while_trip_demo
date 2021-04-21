import 'package:flutter/material.dart';

import 'set_button.dart';

class ActivityPageRefundInfo extends StatefulWidget {

  final bool isSet;
  final String refundInfo;

  ActivityPageRefundInfo({this.refundInfo, this.isSet});

  @override
  _ActivityPageRefundInfoState createState() => _ActivityPageRefundInfoState();
}

class _ActivityPageRefundInfoState extends State<ActivityPageRefundInfo> {
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
                Text('환불 규정'),
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
