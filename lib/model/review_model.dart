class ReviewModel {
  String reviewKey;
  String storeKey;
  String userKey;
  String storeName;
  int score;
  String comment;
  DateTime time;

  ReviewModel.fromMap(Map<String, dynamic> map)
      : reviewKey = map['reviewKey'],
        storeKey = map['storeKey'],
        userKey = map['userKey'],
        storeName = map['storeName'],
        score = map['score'],
        comment = map['comment'],
        time = map['time'];
}
