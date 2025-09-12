double calculateTotalAmount(List dataList, String key) {
  double totalAmount = 0.0;
  if (dataList.isNotEmpty) {
    for (var data in dataList) {
      final double amount = data[key];
      totalAmount += amount;
    }
    return totalAmount;
  } else {
    return 0.0;
  }
}
