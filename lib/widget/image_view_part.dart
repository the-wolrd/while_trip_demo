import 'dart:async';

import 'package:flutter/material.dart';
import 'package:while_trip_demo/constant/constants.dart';

class ImageViewPart extends StatefulWidget {

  final List<dynamic> imgUrls;
  final double imageHeight;

  ImageViewPart({this.imgUrls, this.imageHeight});

  @override
  _ImageViewPartState createState() => _ImageViewPartState();
}

class _ImageViewPartState extends State<ImageViewPart> {

  int _pageNum = 1;
  final PageController _pageController = PageController();
  LittleDotsPainter _littleDosPainter;

  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer){
      if(_pageController.page < widget.imgUrls.length - 1) {
        _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else {
        _pageController.animateToPage(0, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
    _littleDosPainter = LittleDotsPainter(deviceSize: size, imageHeight: widget.imageHeight, page: 0.0, totalNum: widget.imgUrls.length);
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
      _littleDosPainter = LittleDotsPainter(deviceSize: size,imageHeight:widget.imageHeight, page: _pageController.page, totalNum: widget.imgUrls.length);
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
                color: Colors.black54
              ),
              child: Center(child: Text('$_pageNum/${widget.imgUrls.length}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0),)),
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
      itemCount: widget.imgUrls.length,
        itemBuilder: (context, index){
          return Image.asset('assets/advertise/advertise${index+1}.png', fit: BoxFit.cover,);
        });
  }
}

class LittleDotsPainter extends CustomPainter{

  final Size deviceSize;
  final double imageHeight;
  final double page;

  final int totalNum;


  LittleDotsPainter({this.deviceSize, this.imageHeight, this.page, this.totalNum});

  @override
  void paint(Canvas canvas, Size size) {

    for(var i = 0; i < totalNum; i++){
      double x_posi = 8.0 * (totalNum - 1) - 16.0 * i;
      canvas.drawCircle(Offset(deviceSize.width * 0.5 + x_posi,  imageHeight - 10.0), 4.0, Paint()..color = Colors.grey[300].. style=PaintingStyle.fill);
    }


    if(page != null) {
      canvas.drawCircle(Offset(deviceSize.width * 0.5 - 24.0 + page*16.0,  imageHeight - 10.0), 4.0, Paint()..color = Colors.lightBlueAccent);
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as LittleDotsPainter).page != page;
  }

}
