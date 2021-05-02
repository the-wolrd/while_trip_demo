import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_trip_demo/model/user_model.dart';
import 'package:while_trip_demo/constant/constants.dart';

import 'package:while_trip_demo/network/firebase/transformers.dart';

class FirebaseUserNetwork with Transformers{


  Future<void> createUser(Map<String, dynamic> userData) async {

    final newUserRef = FirebaseFirestore.instance.collection(COLLECTION_USERS).doc('${userData[KEY_USERKEY]}');

    final documentSnapshot = await newUserRef.get();

    return FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      if(!documentSnapshot.exists){
        await tx.set(newUserRef, userData);
      }
    });
  }

  Stream<UserModel> getAUserModelStream(String userKey){
    return FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(userKey)
        .snapshots()
        .transform(toUser);
  }

  Future<void> transferBusinessStatus(String userKey) async {
    final userRef = FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey);
    var data = await userRef.get();
    await userRef.update({KEY_ISBUSINESS: !data[KEY_ISBUSINESS]});
  }

  Future<void> transferFavoritesStore(String storeKey, String userKey) async {
    final userRef = FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey);
    final storeRef = FirebaseFirestore.instance.collection(COLLECTION_STORES).doc(storeKey);




  }

}

FirebaseUserNetwork firebaseUserNetwork = FirebaseUserNetwork();