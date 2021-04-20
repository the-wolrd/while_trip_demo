import 'package:flutter/material.dart';

class ActivityPageReview extends StatefulWidget {

  final bool isSet;
  final List<dynamic> reviews; // 이거 dynamic 부분 reviewKey 값들이 넘어온다.

  ActivityPageReview({this.reviews, this.isSet});

  @override
  _ActivityPageReviewState createState() => _ActivityPageReviewState();
}

class _ActivityPageReviewState extends State<ActivityPageReview> {
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
                Text('리뷰'),
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
