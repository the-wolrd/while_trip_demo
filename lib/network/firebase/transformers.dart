import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_trip_demo/model/review_model.dart';
import 'package:while_trip_demo/model/store_model.dart';
import 'package:while_trip_demo/model/user_model.dart';

class Transformers {
  final toStore = StreamTransformer<DocumentSnapshot, StoreModel>.fromHandlers(
    handleData: (snapshot, sink) async {
      sink.add(StoreModel.fromMap(snapshot.data())); // stream에서 바로 transform 하기 위해 UserModel에서 fromSnapShot을 만듬.
    }
  );

  final toUser = StreamTransformer<DocumentSnapshot, UserModel>.fromHandlers(
      handleData: (snapshot, sink) async {
        sink.add(UserModel.fromMap(snapshot.data())); // stream에서 바로 transform 하기 위해 UserModel에서 fromSnapShot을 만듬.
      }
  );

  final toReview = StreamTransformer<DocumentSnapshot, ReviewModel>.fromHandlers(
      handleData: (snapshot, sink) async {
        sink.add(ReviewModel.fromMap(snapshot.data())); // stream에서 바로 transform 하기 위해 UserModel에서 fromSnapShot을 만듬.
      }
  );

}