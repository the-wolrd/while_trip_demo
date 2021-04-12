import 'package:flutter/material.dart';
import '../constant/size.dart';

class ActivityCard extends StatelessWidget {

  final String storeName;
  final String location;
  final double score;
  final int reviewNum;
  final String content;
  final String price_final;
  final String price_origin;
  final String img_path; // only in demo

  const ActivityCard({this.storeName, this.location, this.score, this.reviewNum, this.content, this.price_final, this.price_origin, this.img_path});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.9,
      height: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
            image: DecorationImage(
              image: AssetImage('assets/stores/${img_path}'),
              fit: BoxFit.fill
            )
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              color: Colors.black54
            ),
          ),
          Positioned(
              top: 15.0,
              right: 15.0,
              child: Icon(Icons.star_border, color: Colors.white, size: 30.0,)),
          Positioned(
              bottom: 20.0,
              left: 20.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(storeName, style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white, fontSize: 25.0),),
                  SizedBox(width: 10.0,),
                  Text(location, style: TextStyle(color:Colors.white70, fontSize: 15.0))
                ],
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.white, size: 20.0,),
                  Text(' ${score} (${reviewNum}명)',  style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white, fontSize: 15.0))
                ],
              ),
              SizedBox(height: 5.0,),
              Row(
                children: [
                  Text('${content} ${price_final} ', style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white, fontSize: 20.0)),
                  Text('${price_origin}', style: TextStyle(color:Colors.white70, fontSize: 15.0,decoration: TextDecoration.lineThrough))
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
