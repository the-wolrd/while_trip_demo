import 'package:flutter/material.dart';
import 'package:while_trip_demo/model/store_model.dart';
import 'package:while_trip_demo/constant/constants.dart';

import 'activity_page.dart';

class ActivityCard extends StatelessWidget {

  final StoreModel store;

  const ActivityCard({this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.9,
      height: size.width,
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityPage(store:store)));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                color: Colors.black54
              ),
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
                  Text(store.storeName, style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white, fontSize: 25.0),),
                  SizedBox(width: 10.0,),
                  Text(store.location, style: TextStyle(color:Colors.white70, fontSize: 15.0))
                ],
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.white, size: 20.0,),
                  Text(' ${store.lon} (${store.storePhone}명)',  style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white, fontSize: 15.0))
                ],
              ),
              SizedBox(height: 5.0,),
              Row(
                children: [
                  Text('${store.info} ${store.lat} ', style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white, fontSize: 20.0)),
                  Text('${store.cautionInfo}', style: TextStyle(color:Colors.white70, fontSize: 15.0,decoration: TextDecoration.lineThrough))
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
