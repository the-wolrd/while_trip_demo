import 'package:while_trip_demo/model/review_model.dart';
import 'package:while_trip_demo/model/store_model.dart';
import 'package:while_trip_demo/model/userModel.dart';

import 'firebase/firebase_review_network.dart';
import 'firebase/firebase_store_network.dart';
import 'firebase/firebase_user_network.dart';

class NetworkFunction {

  Future<void> createStore(Map<String, dynamic> storeData) async {
    await firebaseStoreNetwork.createStore(storeData);
  }

  Future<void> createUser(Map<String, dynamic> userData) async {
    await firebaseUserNetwork.createUser(userData);
  }

  Future<void> createReview (Map<String, dynamic> reviewData) async {
    await firebaseReviewNetwork.createReview(reviewData);
  }

  Stream<StoreModel> getAStoreModel(String storeKey) {
    return firebaseStoreNetwork.getAStoreModel(storeKey);
  }
  Stream<UserModel> getAUserModel(String userKey) {
    return firebaseUserNetwork.getAUserModel(userKey);
  }
  Stream<ReviewModel> getAReviewModel(String reviewKey) {
    return firebaseReviewNetwork.getAReviewModel(reviewKey);
  }

}

NetworkFunction networkFunction = NetworkFunction();