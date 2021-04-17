import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FirebaseImageNetwork{

  String _getImagePathByStoreKeyUploadTime(String storeKey, String uploadTime) => 'store/$storeKey/$uploadTime.png';

  Future<TaskSnapshot> uploadProfileImg(File imageFile, String storeKey, String uploadTime){
    try{
      final Reference storageReference = FirebaseStorage.instance.ref().child(_getImagePathByStoreKeyUploadTime(storeKey, uploadTime));
      final UploadTask uploadTask = storageReference.putFile(imageFile);

      return uploadTask.whenComplete(() => null);
    } catch (e){
      print(e);
      return null;
    }
  }

  Future<dynamic> getProfileImgUrlFromKeyAndTime (String storeKey, String uploadTime) async {
    return await FirebaseStorage.instance.ref().child(_getImagePathByStoreKeyUploadTime(storeKey, uploadTime)).getDownloadURL();
  }

  Future<dynamic> getProfileImgUrlsFromStore (String storeKey) async {
    List<String> imgUrls = [];
    ListResult result = await FirebaseStorage.instance.ref('store/$storeKey').listAll();

    result.items.forEach((element) async{
      String eachUrl = await element.getDownloadURL();
      imgUrls.add(eachUrl);
    });

    return imgUrls;
  }

  Future<void> deleteProfileImgFromUrl(String imgUrl) async {
    await print(imgUrl);
    if(FirebaseStorage.instance.refFromURL(imgUrl) != null){
      await FirebaseStorage.instance.refFromURL(imgUrl).delete().onError((error, stackTrace) => print(error));
    }
  }

}

FirebaseImageNetwork firebaseImageNetwork = FirebaseImageNetwork();