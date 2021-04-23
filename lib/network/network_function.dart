import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:while_trip_demo/model/review_model.dart';
import 'package:while_trip_demo/model/store_model.dart';
import 'package:while_trip_demo/model/userModel.dart';

import 'firebase/firebase_review_network.dart';
import 'firebase/firebase_store_network.dart';
import 'firebase/firebase_user_network.dart';
import 'firebase/firebase_image_network.dart';
import 'naver_api/naver_api_network.dart';

class NetworkFunction {

  Future<void> createStore(Map<String, dynamic> storeData) => firebaseStoreNetwork.createStore(storeData);

  Future<void> updateStore(Map<String, dynamic> storeData, String storeKey) => firebaseStoreNetwork.updateStore(storeData, storeKey);

  Future<void> createUser(Map<String, dynamic> userData) => firebaseUserNetwork.createUser(userData);

  Future<void> createReview (Map<String, dynamic> reviewData) => firebaseReviewNetwork.createReview(reviewData);

  Future<void> uploadProfileImg({@required File imageFile, @required String storeKey, @required String uploadTime}) => firebaseImageNetwork.uploadProfileImg(imageFile, storeKey, uploadTime);

  Future<void> deleteProfileImg({@required String imgUrl}) => firebaseImageNetwork.deleteProfileImgFromUrl(imgUrl);

  Future<dynamic> getProfileImgUrlFromKeyAndTime({@required String storeKey, @required String uploadTime}) => firebaseImageNetwork.getProfileImgUrlFromKeyAndTime(storeKey, uploadTime);

  Future<dynamic> getProfileImgUrls({@required String storeKey}) => firebaseImageNetwork.getProfileImgUrlsFromStore(storeKey);

  Stream<StoreModel> getAStoreModel({@required String storeKey}) => firebaseStoreNetwork.getAStoreModel(storeKey);

  Stream<UserModel> getAUserModel({@required String userKey}) => firebaseUserNetwork.getAUserModel(userKey);

  Stream<ReviewModel> getAReviewModel({@required String reviewKey}) => firebaseReviewNetwork.getAReviewModel(reviewKey);

  Future<Map<String, dynamic>> getAddressFromQuery (String query) {
    return naverApiNetwork.getAddressInfoFromQuery(query);
  }

  Future<Map<String, dynamic>> getAddressInfoFromPosition ({double lat, double lon}){
    return naverApiNetwork.getAddressInfoFromPosition(latitude: lat, longitude: lon);
  }

}

NetworkFunction networkFunction = NetworkFunction();