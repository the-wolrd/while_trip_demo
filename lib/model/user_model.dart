import 'package:while_trip_demo/constant/constants.dart';

class UserModel {
  final String userKey;
  final String loginType;
  final String userEmail;
  final String userNickname;
  final Map<String, dynamic> userInfo;
  final String profileImg;
  final bool isBusiness;
  final List<dynamic> userLocations; // dynamic : Map 형태  {'title': '집', 'address': '대전 유성구 대학로 291', 'detail': 'w5-2 스타트업빌리지 204호', 'lat': 36.3693545, 'lon':127.355723}
  final int range;  // 5000m , 10000m 요런식으로 사용할 예정
  final List<dynamic> activities;
  final List<dynamic> favorites;
  final List<dynamic> myReviews;

  final String theme;     // origin, dark
  final String language;  // kr, en

  UserModel.fromMap(Map<String, dynamic> map)
      : userKey = map[KEY_USERKEY],
        loginType = map[KEY_LOGINTYPE],
        userEmail = map[KEY_USEREMAIL],
        userNickname = map[KEY_USERNICKNAME],
        userInfo = map[KEY_USERINFO],
        profileImg = map[KEY_PROFILEIMG],
        isBusiness = map[KEY_ISBUSINESS],
        userLocations = map[KEY_USERLOCATIONS],
        range = map[KEY_RANGE],
        activities = map[KEY_ACTIVITIES],
        favorites = map[KEY_FAVORITES],
        myReviews = map[KEY_MYREVIEWS],
        theme = map[KEY_THEME],
        language = map[KEY_LANGUAGE];
}
