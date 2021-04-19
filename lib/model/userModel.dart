import 'package:while_trip_demo/constant/constants.dart';

class UserModel {
  final String userKey;
  final String loginType;
  final String userEmail;
  final String userNickname;
  final Map<String, dynamic> userInfo;
  final bool isBusiness;
  final String userLocation;
  final double lat;
  final double lon;
  final double range;
  final List<dynamic> activities;
  final List<dynamic> favorites;
  final List<dynamic> myReviews;

  UserModel.fromMap(Map<String, dynamic> map)
      : userKey = map[KEY_USERKEY],
        loginType = map[KEY_LOGINTYPE],
        userEmail = map[KEY_USEREMAIL],
        userNickname = map[KEY_USERNICKNAME],
        userInfo = map[KEY_USERINFO],
        isBusiness = map[KEY_ISBUSINESS],
        userLocation = map[KEY_USERLOCATION],
        lat = map[KEY_LAT],
        lon = map[KEY_LON],
        range = map[KEY_RANGE],
        activities = map[KEY_ACTIVITIES],
        favorites = map[KEY_FAVORITES],
        myReviews = map[KEY_MYREVIEWS];
}
