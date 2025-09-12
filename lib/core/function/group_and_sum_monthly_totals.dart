void groupAndSumMonthlyTotals(String dataType, List totalList) {
  Map<int, double> monthlyTotals = {};

  for (var item in totalList) {
    final int monthIndex = item["index"];
    final double amount =
        (item[dataType] is int)
            ? (item[dataType] as int).toDouble()
            : (item[dataType] is double)
            ? item[dataType]
            : 0.0;
    if (monthlyTotals.containsKey(monthIndex)) {
      monthlyTotals[monthIndex] = monthlyTotals[monthIndex]! + amount;
    } else {
      monthlyTotals[monthIndex] = amount;
    }
  }

  totalList.clear();
  monthlyTotals.forEach((month, amount) {
    totalList.add({"index": month, dataType: amount});
  });
}
