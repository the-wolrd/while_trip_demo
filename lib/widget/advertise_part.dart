import 'dart:async';

import 'package:flutter/material.dart';
import '../constant/size.dart';

class AdvertisePart extends StatefulWidget {


  @override
  _AdvertisePartState createState() => _AdvertisePartState();
}

class _AdvertisePartState extends State<AdvertisePart> {

  int _pageNum = 0;
  PageController _pageController = PageController();
  LittleDotsPainter _littleDosPainter = LittleDotsPainter(deviceSize: size, page: 0.0);

  Timer _timer;

  @override
  void initState() {
    _timer = new Timer.periodic(Duration(seconds: 2), (timer){
      if(_pageController.page <3.0)
        _pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      else
        _pageController.animateToPage(0, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    });
    _pageController.addListener(onPageChanged);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(){
    setState(() {
      _pageNum = _pageController.page.toInt() + 1;
      _littleDosPainter = LittleDotsPainter(deviceSize: size, page: _pageController.page);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: 200.0,
      child: Stack(
        children: [
          _images(),
          Positioned(
            bottom: 10.0,
            right: 0.0,
            child:Container(
              height:30.0,
              width: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
                color: Colors.black54
              ),
              child: Center(child: Text('${_pageNum}/4', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0),)),
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
      itemCount: 4,
        itemBuilder: (context, index){
          return Image.asset('assets/advertise/advertise${index+1}.png');
        });
  }
}

class LittleDotsPainter extends CustomPainter{

  final Size deviceSize;
  final double page;

  LittleDotsPainter({this.deviceSize, this.page});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(deviceSize.width * 0.5 - 24.0,  190.0), 5.0, Paint()..color = Colors.red..strokeWidth = 2 .. style=PaintingStyle.stroke);
    canvas.drawCircle(Offset(deviceSize.width * 0.5 - 8.0,  190.0), 5.0, Paint()..color = Colors.red..strokeWidth = 2 .. style=PaintingStyle.stroke);
    canvas.drawCircle(Offset(deviceSize.width * 0.5 + 8.0,  190.0), 5.0, Paint()..color = Colors.red..strokeWidth = 2 .. style=PaintingStyle.stroke);
    canvas.drawCircle(Offset(deviceSize.width * 0.5 + 24.0,  190.0), 5.0, Paint()..color = Colors.red..strokeWidth = 2 .. style=PaintingStyle.stroke);

    if(page != null)
      canvas.drawCircle(Offset(deviceSize.width * 0.5 - 24.0 + page*16.0,  190.0), 5.0, Paint()..color = Colors.yellow);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as LittleDotsPainter).page != page;
  }

}
