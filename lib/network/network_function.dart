import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:while_trip_demo/model/review_model.dart';
import 'package:while_trip_demo/model/store_model.dart';
import 'package:while_trip_demo/model/user_model.dart';

import 'firebase/firebase_review_network.dart';
import 'firebase/firebase_store_network.dart';
import 'firebase/firebase_user_network.dart';
import 'firebase/firebase_image_network.dart';
import 'naver_api/naver_api_network.dart';

class NetworkFunction {

  // store 관련 함수들

  Future<void> createStore(Map<String, dynamic> storeData) => firebaseStoreNetwork.createStore(storeData);

  Future<void> updateStore(Map<String, dynamic> storeData, String storeKey) => firebaseStoreNetwork.updateStore(storeData, storeKey);

  Future<void> removeStore(String storeKey) => firebaseStoreNetwork.removeStore(storeKey);

  Stream<StoreModel> getAStoreModel({@required String storeKey}) => firebaseStoreNetwork.getAStoreModel(storeKey);

  Future<List<StoreModel>> getActivitiesFromUserKey(String userKey) => firebaseStoreNetwork.getActivitiesFromUserKey(userKey);

  Future<List<StoreModel>> getFavoritesFromUserKey(String userKey) => firebaseStoreNetwork.getFavoritesFromUserKey(userKey);



  // user 관련 함수들

  Future<void> createUser(Map<String, dynamic> userData) => firebaseUserNetwork.createUser(userData);

  Stream<UserModel> getAUserModel({@required String userKey}) => firebaseUserNetwork.getAUserModel(userKey);

  Future<void> transferBusinessStatus ({@required String userKey}) => firebaseUserNetwork.transferBusinessStatus(userKey);


  // review 관련 함수들

  Future<void> createReview (Map<String, dynamic> reviewData) => firebaseReviewNetwork.createReview(reviewData);

  Stream<ReviewModel> getAReviewModel({@required String reviewKey}) => firebaseReviewNetwork.getAReviewModel(reviewKey);

  Future<List<ReviewModel>> getReviewsFromUserKey(String userKey) => firebaseReviewNetwork.getReviewsFromUserKey(userKey);


  // image 업데이트 관련 함수들

  Future<void> uploadProfileImg({@required File imageFile, @required String storeKey, @required String uploadTime}) => firebaseImageNetwork.uploadProfileImg(imageFile, storeKey, uploadTime);

  Future<void> deleteProfileImg({@required String imgUrl}) => firebaseImageNetwork.deleteProfileImgFromUrl(imgUrl);

  Future<dynamic> getProfileImgUrlFromKeyAndTime({@required String storeKey, @required String uploadTime}) => firebaseImageNetwork.getProfileImgUrlFromKeyAndTime(storeKey, uploadTime);

  Future<dynamic> getProfileImgUrls({@required String storeKey}) => firebaseImageNetwork.getProfileImgUrlsFromStore(storeKey);


  // 네이버 api 관련 함수들

  Future<Map<String, dynamic>> getAddressFromQuery (String query) => naverApiNetwork.getAddressInfoFromQuery(query);

  Future<Map<String, dynamic>> getAddressInfoFromPosition ({double lat, double lon}) => naverApiNetwork.getAddressInfoFromPosition(latitude: lat, longitude: lon);


}

NetworkFunction networkFunction = NetworkFunction();