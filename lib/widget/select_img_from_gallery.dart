import 'dart:io';
import 'dart:typed_data';


import 'package:while_trip_demo/network/network_function.dart';

import '../model/gallery_state.dart';
import 'package:flutter/material.dart';
import 'package:local_image_provider/device_image.dart';
import 'package:local_image_provider/local_image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SelectFromGallery extends StatefulWidget {

  final String storeKey;
  final Function updateFunc;

  SelectFromGallery({this.storeKey, this.updateFunc});

  @override
  _SelectFromGalleryState createState() => _SelectFromGalleryState();
}

class _SelectFromGalleryState extends State<SelectFromGallery> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryState>(builder:
        (BuildContext context, GalleryState galleryState, Widget child) {
      return SafeArea(
        child: Scaffold(
          body: GridView.count(
              crossAxisCount: 3, children: getImages(context, galleryState)),
        ),
      );
    });
  }

  List<Widget> getImages(BuildContext context, GalleryState galleryState) {
    if (galleryState == null || galleryState.images == null){
      return List.generate(30, (index) => CircularProgressIndicator()).toList();
    }
    else{
      return galleryState.images
          .map((localImage) => InkWell(
        onTap: () async {
          Uint8List bytes =
          await localImageToBytes(galleryState, localImage);

          final String uploadTime = DateTime.now().millisecondsSinceEpoch.toString();

          try {
            final path = join(
                (await getTemporaryDirectory()).path, '$uploadTime.png');

            File imageFile = File(path)..writeAsBytesSync(bytes);

            await networkFunction.uploadProfileImg(imageFile: imageFile, storeKey: widget.storeKey, uploadTime: uploadTime);

            String profileImgUrl =
            await networkFunction.getProfileImgUrlFromKeyAndTime(storeKey: widget.storeKey, uploadTime: uploadTime);

            widget.updateFunc(profileImgUrl);
            Navigator.pop(context);

          } catch (e) {}
        },
        child: Image(
          image: DeviceImage(localImage, scale: 0.5),
          // memory loading 이 너무 메모리 많이 써서, 스케일을 줄여주자.
          fit: BoxFit.cover,
        ),
      ))
          .toList();
    }

  }

  Future<Uint8List> localImageToBytes(
      GalleryState galleryState, LocalImage localImage) {
    return localImage.getScaledImageBytes(galleryState.localImageProvider, 1.0);
  }
}
