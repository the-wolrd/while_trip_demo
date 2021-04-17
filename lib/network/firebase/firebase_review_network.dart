import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:while_trip_demo/model/review_model.dart';
import 'package:while_trip_demo/model/store_model.dart';

import 'package:while_trip_demo/network/firebase/transformers.dart';

class FirebaseReviewNetwork with Transformers{


  Future<void> createReview(Map<String, dynamic> reviewData) async {

    final newReviewRef = FirebaseFirestore.instance.collection('reviews').doc('${reviewData['reviewKey']}');

    final documentSnapshot = await newReviewRef.get();

    return FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      if(!documentSnapshot.exists){

        final selStoreRef = FirebaseFirestore.instance.collection('stores').doc('${reviewData['storeKey']}');
        final selUserRef = FirebaseFirestore.instance.collection('users').doc('${reviewData['userKey']}');

        await tx.update(selStoreRef, {'reviews':FieldValue.arrayUnion([reviewData['reviewKey']])});
        await tx.update(selUserRef, {'myReviews':FieldValue.arrayUnion([reviewData['reviewKey']])});
        await tx.set(newReviewRef, reviewData);

      }
    });
  }

  Stream<ReviewModel> getAReviewModel(String reviewKey){
    return FirebaseFirestore.instance
        .collection('reviews')
        .doc(reviewKey)
        .snapshots()
        .transform(toReview);
  }

}

FirebaseReviewNetwork firebaseReviewNetwork = FirebaseReviewNetwork();