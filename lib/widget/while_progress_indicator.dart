import 'package:flutter/cupertino.dart';

class WhileProgressIndicator extends StatelessWidget{

  final double containerSize;
  final double progressSize;

  const WhileProgressIndicator(
      {Key key, this.containerSize = 200.0, this.progressSize = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: containerSize,
        height: containerSize,
        child: Center(
            child: SizedBox(
                height: progressSize,
                width: progressSize,
                child: Image.asset('assets/loading_img.gif'))));
  }
}