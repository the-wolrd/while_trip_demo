import 'dart:async';

import 'package:flutter/material.dart';
import 'package:while_trip_demo/constant/constants.dart';

class AdvertisePart extends StatefulWidget {


  @override
  _AdvertisePartState createState() => _AdvertisePartState();
}

int _totalNum = 4;

class _AdvertisePartState extends State<AdvertisePart> {

  int _pageNum = 1;
  final PageController _pageController = PageController();
  final double _imageHeight = 200.0;
  LittleDotsPainter _littleDosPainter;

  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer){
      if(_pageController.page < _totalNum - 1) {
        _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else {
        _pageController.animateToPage(0, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
    _littleDosPainter = LittleDotsPainter(deviceSize: size, imageHeight: _imageHeight, page: 0.0);
    _pageController.addListener(onPageChanged);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void onPageChanged(){
    setState(() {
      _pageNum = _pageController.page.toInt() + 1;
      _littleDosPainter = LittleDotsPainter(deviceSize: size, imageHeight: _imageHeight, page: _pageController.page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: _imageHeight,
      child: Stack(
        children: [
          _images(),
          Positioned(
            bottom: 10.0,
            right: 0.0,
            child:Container(
              height:30.0,
              width: 50.0,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
                color: Colors.black54
              ),
              child: Center(child: Text('$_pageNum/${_totalNum}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0),)),
            ),
          ),
          CustomPaint(
            painter: _littleDosPainter,
          )
        ],
      ),
    );
  }

  PageView _images() {
    return PageView.builder(
      controller: _pageController,
      itemCount: _totalNum,
        itemBuilder: (context, index){
          return Image.asset('assets/advertise/advertise${index+1}.png', fit: BoxFit.cover,);
        });
  }
}

class LittleDotsPainter extends CustomPainter{

  final Size deviceSize;
  final double imageHeight;
  final double page;


  LittleDotsPainter({this.deviceSize, this.imageHeight, this.page});

  @override
  void paint(Canvas canvas, Size size) {

    for(var i = 0; i < _totalNum; i++){
      double x_posi = 8.0 * (_totalNum - 1) - 16.0 * i;
      canvas.drawCircle(Offset(deviceSize.width * 0.5 + x_posi, imageHeight-10.0), 5.0, Paint()..color = Colors.red..strokeWidth = 2 .. style=PaintingStyle.stroke);
    }

    if(page != null) {
      canvas.drawCircle(Offset(deviceSize.width * 0.5 - 24.0 + page*16.0,  imageHeight-10.0), 5.0, Paint()..color = Colors.yellow);
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as LittleDotsPainter).page != page;
  }

}
