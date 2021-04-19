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

}

FirebaseReviewNetwork firebaseReviewNetwork = FirebaseReviewNetwork();