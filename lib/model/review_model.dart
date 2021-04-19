import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_trip_demo/constant/constants.dart';

class ReviewModel {

  String reviewKey;
  String storeKey;
  String userKey;
  String storeName;
  int score;
  String comment;
  DateTime updateTime;

  String videoUrl; // 나중에 쓰일 일이 있을듯 하여 만들어만 놓기.

  ReviewModel.fromMap(Map<String, dynamic> map)
      : reviewKey = map[KEY_REVIEWKEY],
        storeKey = map[KEY_STOREKEY],
        userKey = map[KEY_USERKEY],
        storeName = map[KEY_STORENMAE],
        score = map[KEY_SCORE],
        comment = map[KEY_COMMENT],
        updateTime = (map[KEY_UPDATETIME] as Timestamp).toDate(),
        videoUrl = map[KEY_VIDEOURL];
}
