import 'package:flutter/material.dart';

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
