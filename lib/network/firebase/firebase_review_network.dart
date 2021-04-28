import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_trip_demo/model/review_model.dart';
import 'package:while_trip_demo/constant/constants.dart';
import 'package:while_trip_demo/network/firebase/transformers.dart';

class FirebaseReviewNetwork with Transformers{


  Future<void> createReview(Map<String, dynamic> reviewData) async {

    final newReviewRef = FirebaseFirestore.instance.collection(COLLECTION_REVIEWS).doc('${reviewData[KEY_REVIEWKEY]}');

    final documentSnapshot = await newReviewRef.get();

    return FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      if(!documentSnapshot.exists){

        final selStoreRef = FirebaseFirestore.instance.collection(COLLECTION_STORES).doc('${reviewData[KEY_STOREKEY]}');
        final selUserRef = FirebaseFirestore.instance.collection(COLLECTION_USERS).doc('${reviewData[KEY_USERKEY]}');

        await tx.update(selStoreRef, {KEY_REVIEWS:FieldValue.arrayUnion([reviewData[KEY_REVIEWKEY]])});
        await tx.update(selUserRef, {KEY_MYREVIEWS:FieldValue.arrayUnion([reviewData[KEY_REVIEWKEY]])});
        await tx.set(newReviewRef, reviewData);

      }
    });
  }

  Stream<ReviewModel> getAReviewModel(String reviewKey){
    return FirebaseFirestore.instance
        .collection(COLLECTION_REVIEWS)
        .doc(reviewKey)
        .snapshots()
        .transform(toReview);
  }

  Future<List<ReviewModel>> getReviewsFromUserKey(String userKey) async {
    // 두가지 방법이 존재할 것 같다.
    // 1. User 컬렉션에 접근해서 각각의 store DB에 접근하는 것
    // 2. 처음부터 Store 컬렉션에 접근해서 where 함수로 userKey가 같은 것을 찾는것..
    // 1번 방법으로 하는게 왠지 좀더 빠를것 같은데.. 왠지 2번이 더 빠를것 같기도 하다.. (애초에 파이어베이스에서 이정도 최적화는 해놓았을거란 생각..)

    final reviewColRef = FirebaseFirestore.instance.collection(COLLECTION_REVIEWS);

    var reviewQuery = await reviewColRef.where(KEY_USERKEY, isEqualTo: userKey).get();

    var reviews = <ReviewModel>[];

    reviewQuery.docs.forEach((element) {
      reviews.add(ReviewModel.fromMap(element.data()));
    });

    // 추후 stores 내에서 orderBy 함수로 순서 변경할 수 있게 하기.

    return reviews;
  }

}

FirebaseReviewNetwork firebaseReviewNetwork = FirebaseReviewNetwork();