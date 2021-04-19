import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_trip_demo/model/store_model.dart';
import 'package:while_trip_demo/constant/constants.dart';

import 'package:while_trip_demo/network/firebase/transformers.dart';

class FirebaseStoreNetwork with Transformers{


  Future<void> createStore(Map<String, dynamic> storeData) async {

    final newStoreRef = FirebaseFirestore.instance.collection(COLLECTION_STORES).doc('${storeData[KEY_STOREKEY]}');

    final documentSnapshot = await newStoreRef.get();

    return FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      if(!documentSnapshot.exists){
        List<Map<String, dynamic>> pricesData = storeData[KEY_PRICES];
        pricesData.forEach((element) async {
          final newSummaryRef = newStoreRef.collection(KEY_PRICES).doc(element.toString());
          await tx.set(newSummaryRef, element);
        });
        await tx.set(newStoreRef, storeData);
      }
    });
  }

  Future<void> updateStore(Map<String, dynamic> storeData, String storeKey) async {

    final newStoreRef = FirebaseFirestore.instance.collection(COLLECTION_STORES).doc(storeKey);

    return FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      List<Map<String, dynamic>> pricesData = storeData[KEY_PRICES];
      pricesData.forEach((element) async {
        final newSummaryRef = newStoreRef.collection(KEY_PRICES).doc(element.toString());
        await tx.set(newSummaryRef, element);
      });
      await tx.set(newStoreRef, storeData);
    });
  }

  Stream<StoreModel> getAStoreModel(String storeKey){
    return FirebaseFirestore.instance
        .collection(COLLECTION_STORES)
        .doc(storeKey)
        .snapshots()
        .transform(toStore);
  }

}

FirebaseStoreNetwork firebaseStoreNetwork = FirebaseStoreNetwork();