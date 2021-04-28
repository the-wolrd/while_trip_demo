import 'package:flutter/material.dart';
import 'package:while_trip_demo/model/review_model.dart';
import 'package:while_trip_demo/model/user_model.dart';
import 'package:while_trip_demo/network/network_function.dart';
import 'package:while_trip_demo/widget/while_progress_indicator.dart';

class MyReviewScreen extends StatefulWidget {

  final UserModel user;

  const MyReviewScreen({this.user});

  @override
  _MyReviewScreenState createState() => _MyReviewScreenState();
}

class _MyReviewScreenState extends State<MyReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                _topBar(),
                _content()
              ],
            )));
  }

  Widget _content(){
   return FutureBuilder(
     future: networkFunction.getReviewsFromUserKey(widget.user.userKey),
     builder: (context, reviewsSnapshot){
       if(!reviewsSnapshot.hasData){
         return WhileProgressIndicator();
       }
       else if(reviewsSnapshot.hasError){
         return Center(child:Text('에러가 발생하였습니다...\n문의 넣어주시면 빠른 시일내에 해결해드리겠습니다.'));
       }
       else{
         return _listReviews(reviewsSnapshot.data);
       }
     }
   );
  }

  Widget _listReviews(List<ReviewModel> reviews){
    if(reviews.isEmpty){
      return Center(child: Text('작성한 리뷰가 없습니다.'),);
    }
    else{
      return Expanded(child: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text('review ${index}'),
          );
        },
      )
        ,);
    }
  }


  Widget _topBar(){
    return Padding(
      padding: const EdgeInsets.only(top:10.0, bottom: 20.0, left: 10.0, right: 10.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          const Expanded(
            child: Center(child: Text('관심목록', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),)),
          ),
          // 같은 사이즈의 IconButton을 넣어 중앙 배열이 되도록 함.
          IconButton(
            icon: const Icon(Icons.star, color: Colors.transparent,), onPressed: null,
          )
        ],
      ),
    );
  }
}
