import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:while_trip_demo/model/store_model.dart';
import 'package:while_trip_demo/constant/constants.dart';

import 'package:while_trip_demo/network/firebase/transformers.dart';

class FirebaseStoreNetwork with Transformers{


  Future<void> createStore(Map<String, dynamic> storeData) async {

    final newStoreRef = FirebaseFirestore.instance.collection(COLLECTION_STORES).doc('${storeData[KEY_STOREKEY]}');
    final ownerRef = FirebaseFirestore.instance.collection(COLLECTION_USERS).doc('${storeData[KEY_OWNERKEY]}');

    final documentSnapshot = await newStoreRef.get();

    return FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      if(!documentSnapshot.exists){
        List<Map<String, dynamic>> pricesData = storeData[KEY_PRICES];
        pricesData.forEach((element) async {
          final newSummaryRef = newStoreRef.collection(KEY_PRICES).doc(element.toString());
          await tx.set(newSummaryRef, element);
        });
        await tx.set(newStoreRef, storeData);
        await tx.update(ownerRef, {KEY_ACTIVITIES: FieldValue.arrayUnion([storeData[KEY_STOREKEY]])});
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

  Future<void> removeStore(String storeKey) async {
    // 나중에 이 기능은 무조건 수정이 필요하다
    // 어디선가 봤는데, 실제 DB상에서 없애는 작업은 절때 하지 않는 것이라고 함.
    // 다만 user가 보기에 삭제된것 처럼만 구현하면 된다.
    // 그리고 삭제하기 전에 status를 넣어서 관리하는 것도 좋을 것 같다. (메이플 캐릭터 삭제가 바로 안되는것 처럼)

    final storeRef = FirebaseFirestore.instance.collection(COLLECTION_STORES).doc(storeKey);
    var documentSnapshot = await storeRef.get();
    var ownerKey = await documentSnapshot.data()[KEY_OWNERKEY];
    final ownerRef = FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(ownerKey);

    return FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      await tx.update(ownerRef, {KEY_ACTIVITIES: FieldValue.arrayRemove([storeKey])});
      await tx.delete(storeRef);
    });
  }

  Stream<StoreModel> getAStoreModel(String storeKey){
    return FirebaseFirestore.instance
        .collection(COLLECTION_STORES)
        .doc(storeKey)
        .snapshots()
        .transform(toStore);
  }

  Future<List<StoreModel>> getActivitiesFromUserKey(String userKey) async {
    // 두가지 방법이 존재할 것 같다.
    // 1. User 컬렉션에 접근해서 각각의 store DB에 접근하는 것
    // 2. 처음부터 Store 컬렉션에 접근해서 where 함수로 userKey가 같은 것을 찾는것..
    // 1번 방법으로 하는게 왠지 좀더 빠를것 같은데.. 왠지 2번이 더 빠를것 같기도 하다.. (애초에 파이어베이스에서 이정도 최적화는 해놓았을거란 생각..)

    final storeColRef = FirebaseFirestore.instance.collection(COLLECTION_STORES);

    var storesQuery = await storeColRef.where(KEY_OWNERKEY, isEqualTo: userKey).get();

    var stores = <StoreModel>[];

    storesQuery.docs.forEach((element) {
      stores.add(StoreModel.fromMap(element.data()));
    });

    // 추후 stores 내에서 orderBy 함수로 순서 변경할 수 있게 하기.

    return stores;
  }

  Future<List<StoreModel>> getFavoritesFromUserKey(String userKey) async {

    final storeColRef = FirebaseFirestore.instance.collection(COLLECTION_STORES);
    final userRef = FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey);

    var documentSnapshot = await userRef.get();
    var favorites = documentSnapshot.data()[KEY_FAVORITES]; // 생각해보니 받아올땐 list 인지 모르는데, List로 사용이 가능한가?

    var stores = <StoreModel>[];


    favorites.forEach((element) async {
      var storeSnapshot = await storeColRef.doc(element).get();
      stores.add(StoreModel.fromMap(storeSnapshot.data()));
    });

    // 추후 stores 내에서 orderBy 함수로 순서 변경할 수 있게 하기.

    return stores;
  }


}

FirebaseStoreNetwork firebaseStoreNetwork = FirebaseStoreNetwork();