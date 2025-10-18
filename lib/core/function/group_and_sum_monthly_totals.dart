void groupAndSumMonthlyTotals(
  String dataType,
  List totalList, {
  bool includeDebts = false,
  double expenses = 0,
  double debts = 0,
}) {
  Map<int, double> monthlyTotals = {};

  for (var item in totalList) {
    final int monthIndex = item["index"];
    double amount =
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
    double finalAmount = amount;
    // eğer includeDebts true ise masraflar ve borçları çıkart
    if (includeDebts) {
      finalAmount = amount - expenses - debts;
    }
    totalList.add({"index": month, dataType: finalAmount});
  });
}
