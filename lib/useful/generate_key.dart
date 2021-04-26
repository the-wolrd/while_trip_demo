class GenerateKey {
  String generateStoreKey(String storeName){
    return '${storeName}_${DateTime.now().millisecondsSinceEpoch}';
  }

  String generateReviewKey(String storeName, String userName){
    return '${storeName}_${userName}_${DateTime.now().millisecondsSinceEpoch}';
  }
}