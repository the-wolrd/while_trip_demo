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
  final List<dynamic> activites;
  final List<dynamic> favorites;
  final List<dynamic> myReviews;

  UserModel.fromMap(Map<String, dynamic> map)
      : userKey = map['userKey'],
        loginType = map['loginType'],
        userEmail = map['userEmail'],
        userNickname = map['userNickname'],
        userInfo = map['userInfo'],
        isBusiness = map['isBusiness'],
        userLocation = map['userLocation'],
        lat = map['lat'],
        lon = map['lon'],
        range = map['range'],
        activites = map['activites'],
        favorites = map['favorites'],
        myReviews = map['myReviews'];


}
