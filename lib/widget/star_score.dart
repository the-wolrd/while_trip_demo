import 'dart:math';

import 'package:flutter/material.dart';

class StarScore extends StatelessWidget {

  final double score;
  final double width;
  final double height;

  StarScore({ this.score, this.width = 120.0, this.height = 20.0});

  @override
  Widget build(BuildContext context) {

    var width_final = min(width, height*6);
    var height_final = width_final / 6;

    return SizedBox(
      width: width_final,
      height: height_final,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index){
            if(score <= index){
              return Padding(
                padding: EdgeInsets.only(right:width_final/30),
                child: Image.asset('assets/stars/star_empty.png', width: width_final/6, fit: BoxFit.fitWidth,),
              );
            }
            else if (score < index + 1){
              return Padding(
                padding: EdgeInsets.only(right:width_final/30),
                child: Image.asset('assets/stars/star_half.png', width:width_final/6, fit: BoxFit.fitWidth,),
              );
            }
            else {
              return Padding(
                padding: EdgeInsets.only(right:width_final/30),
                child: Image.asset('assets/stars/star_full.png', width: width_final/6, fit: BoxFit.fitWidth,),
              );
            }
          }),
    );
  }
}
