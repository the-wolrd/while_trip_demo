import 'package:while_trip_demo/model/review_model.dart';

class CalScore{
  double scoreFromReviews(List<ReviewModel> reviews) {

    var score_total = 0;

    reviews.forEach((element) {
      score_total += element.score;
    });

    return (reviews.isEmpty)? 0: score_total / reviews.length;
  }
}
