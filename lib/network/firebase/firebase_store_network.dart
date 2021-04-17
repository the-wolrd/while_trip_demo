import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:while_trip_demo/model/store_model.dart';

import 'package:while_trip_demo/network/firebase/transformers.dart';

class FirebaseStoreNetwork with Transformers{


  Future<void> createStore(Map<String, dynamic> storeData) async {

    final newStoreRef = FirebaseFirestore.instance.collection('stores').doc('${storeData['storeKey']}');

    final documentSnapshot = await newStoreRef.get();

    return FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      if(!documentSnapshot.exists){
        List<Map<String, dynamic>> summaryData = storeData['summarys'];
        summaryData.forEach((element) async {
          final newSummaryRef = newStoreRef.collection('summarys').doc(element.toString());
          await tx.set(newSummaryRef, element);
        });
        await tx.set(newStoreRef, storeData);
      }
    });
  }

  Stream<StoreModel> getAStoreModel(String storeKey){
    return FirebaseFirestore.instance
        .collection('stores')
        .doc(storeKey)
        .snapshots()
        .transform(toStore);
  }

}

FirebaseStoreNetwork firebaseStoreNetwork = FirebaseStoreNetwork();