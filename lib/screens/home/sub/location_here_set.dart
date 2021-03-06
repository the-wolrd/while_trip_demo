import 'dart:async';
import 'dart:io';
import 'package:while_trip_demo/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:while_trip_demo/network/network_function.dart';

class LocationHereSet extends StatefulWidget {


  @override
  _LocationHereSetState createState() => _LocationHereSetState();
}

class _LocationHereSetState extends State<LocationHereSet> {

  bool _isStop = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<NaverMapController> _controller = Completer();

  MapType _mapType = MapType.Basic;
  LocationTrackingMode _trackingMode = LocationTrackingMode.Follow;



  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      key: scaffoldKey,
      body: Column(
        children: [
          SizedBox(
            width: size.width,
            height: size.width * 1.5,
            child: Stack(
              children: <Widget>[
                NaverMap(
                  onMapCreated: onMapCreated,
                  mapType: MapType.Basic,
                  initLocationTrackingMode: _trackingMode,
                  locationButtonEnable: true,
                  indoorEnable: true,
                  onCameraChange: _onCameraChange,
                  onCameraIdle: _onCameraIdle,
                  onMapTap: _onMapTap,
                  onMapLongTap: _onMapLongTap,
                  onMapDoubleTap: _onMapDoubleTap,
                  onMapTwoFingerTap: _onMapTwoFingerTap,
                  onSymbolTap: _onSymbolTap,
                ),
                Center(
                  child: Image.asset('assets/map/target.png', height: 100.0, fit: BoxFit.fitHeight, color: _isStop?Colors.red:Colors.grey,),
                ),
                _trackingModeSelector(),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 3,),
                  Text(_isStop?'?????????????????????':'...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                  Spacer(flex: 1,),
                  Text(_isStop?'??????????????? ????????? ????????? 291':'...', style: TextStyle(color: Colors.grey, fontSize: 15.0),),
                  Spacer(flex: 2,),
                  SizedBox(
                    width: size.width,
                    height: 50.0,
                    child: InkWell(
                      onTap: () async {
                        var data = await networkFunction.getAddressInfoFromPosition(lat: 37.56058579485761 , lon:126.98526495408939);
                        print(data['results']);

                        String detail = data['results'][0]['region'].toString();
                        // var data3 = await networkFunction.getAddressInfoFromPositionAndQuery('?????? 2???', lat:36.3647903 , lon: 127.3556164);
                        // print(data3);

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: _isStop? Colors.lightBlueAccent:Colors.grey
                        ),
                        child: Center(child: Text(_isStop?'??? ????????? ????????????':'...', style: TextStyle(fontSize: 20.0,color: Colors.white),)),
                      ),
                    ),
                  ),
                  Spacer(flex: 3,),
                ],
              ),
            ),
          )

        ],
      )));
  }


  _onMapTap(LatLng position) async{
//    scaffoldKey.currentState.showSnackBar(SnackBar(
//      content:
//      Text('[onTap] lat: ${position.latitude}, lon: ${position.longitude}'),
//      duration: Duration(milliseconds: 500),
//      backgroundColor: Colors.black,
//    ));
  }

  _onMapLongTap(LatLng position) {
//    scaffoldKey.currentState.showSnackBar(SnackBar(
//      content: Text(
//          '[onLongTap] lat: ${position.latitude}, lon: ${position.longitude}'),
//      duration: Duration(milliseconds: 500),
//      backgroundColor: Colors.black,
//    ));
  }

  _onMapDoubleTap(LatLng position) {
//    scaffoldKey.currentState.showSnackBar(SnackBar(
//      content: Text(
//          '[onDoubleTap] lat: ${position.latitude}, lon: ${position.longitude}'),
//      duration: Duration(milliseconds: 500),
//      backgroundColor: Colors.black,
//    ));
  }

  _onMapTwoFingerTap(LatLng position) {
//    scaffoldKey.currentState.showSnackBar(SnackBar(
//      content: Text(
//          '[onTwoFingerTap] lat: ${position.latitude}, lon: ${position.longitude}'),
//      duration: Duration(milliseconds: 500),
//      backgroundColor: Colors.black,
//    ));
  }

  _onSymbolTap(LatLng position, String caption) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
          '[onSymbolTap] caption: $caption, lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _mapTypeSelector() {
    return SizedBox(
      height: kToolbarHeight,
      child: ListView.separated(
        itemCount: MapType.values.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => SizedBox(width: 16),
        itemBuilder: (_, index) {
          final type = MapType.values[index];
          String title;
          switch (type) {
            case MapType.Basic:
              title = '??????';
              break;
            case MapType.Navi:
              title = '??????';
              break;
            case MapType.Satellite:
              title = '??????';
              break;
            case MapType.Hybrid:
              title = '????????????';
              break;
            case MapType.Terrain:
              title = '?????????';
              break;
          }

          return GestureDetector(
            onTap: () => _onTapTypeSelector(type),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3)]),
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              ),
            ),
          );
        },
      ),
    );
  }

  _trackingModeSelector() {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: _onTapTakeSnapShot,
        child: Container(
          margin: EdgeInsets.only(right: 16, bottom: 48),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                )
              ]),
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.photo_camera,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ?????? ?????? ?????????
  void onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
  }

  /// ?????? ?????? ?????????
  void _onTapTypeSelector(MapType type) async {
    if (_mapType != type) {
      setState(() {
        _mapType = type;
      });
    }
  }

  /// my location button
  // void _onTapLocation() async {
  //   final controller = await _controller.future;
  //   controller.setLocationTrackingMode(LocationTrackingMode.Follow);
  // }

  void _onCameraChange(
      LatLng latLng, CameraChangeReason reason, bool isAnimated) {
    if(_isStop) {
      setState(() {
        _isStop = false;
      });
    }
    print('????????? ????????? >>> ?????? : ${latLng.latitude}, ${latLng.longitude}'
        '\n??????: $reason'
        '\n??????????????? ??????: $isAnimated');
  }

  void _onCameraIdle() async {
    if(!_isStop) {
      setState(() {
        _isStop = true;
      });
    }

    await _controller.future.then((value) => value.getCameraPosition().then((value) => print(value.target)));

    print('????????? ????????? ??????');
  }

  /// ?????? ?????????
  void _onTapTakeSnapShot() async {
    final controller = await _controller.future;
    controller.takeSnapshot((path) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: path != null
                  ? Image.file(
                File(path),
              )
                  : Text('path is null!'),
              titlePadding: EdgeInsets.zero,
            );
          });
    });
  }

}
