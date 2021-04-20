import 'package:flutter/material.dart';

class ActivityPagePrice extends StatefulWidget {

  final bool isSet;
  final List<dynamic> prices; // 이거 dynamic 부분 Map 형태로 넘어온다.

  ActivityPagePrice({this.prices, this.isSet});

  @override
  _ActivityPagePriceState createState() => _ActivityPagePriceState();
}

class _ActivityPagePriceState extends State<ActivityPagePrice> {
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
                Text('가격'),
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
