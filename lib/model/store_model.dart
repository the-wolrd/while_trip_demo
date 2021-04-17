class StoreModel {

  final String storeKey; // 가게 고유키
  final String ownerKey; // 가게 userKey
  final List<dynamic> profileImgs; // 가게 사진들 (들어갈 값은, firestorage에 인터넷링크)
  final String field; // 활동 형태 ex. 서핑, 승마
  final String storeName; // 가게 이름
  final String location; // 가게 위치
  final String detail; // 가게 세부위치
  final double lat; // 위도
  final double lon; // 경도
  final String info; // 가게 설명
  final List<dynamic> reviews; // 리뷰들 리스트 (각 학목은 reviewKey 값)

  final List<dynamic> summarys; // 요약

  final String specificInfo; // 상세 정보
  final String refundInfo; // 환불 규정
  final String cautionInfo; // 유의 사항
  final String homeLink; // 가게 링크
  final String storePhone; // 가게 전화번호

  StoreModel.fromMap(Map<String, dynamic> map)
      : storeKey = map['storeKey'],
        ownerKey = map['ownerKey'],
        profileImgs = map['profileImgs'],
        field = map['field'],
        storeName = map['storeName'],
        location = map['location'],
        detail = map['detail'],
        lat = map['lat'],
        lon = map['lon'],
        info = map['info'],
        reviews = map['reviews'],
        summarys = map['summarys'],
        specificInfo = map['specificInfo'],
        refundInfo = map['refundInfo'],
        cautionInfo = map['cautionInfo'],
        homeLink = map['homeLink'],
        storePhone = map['storePhone'];
}
