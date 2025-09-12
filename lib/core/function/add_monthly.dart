void addMonthly(
  String dataType,
  String dataType2,
  List dataList,
  List totalList,
) {
  for (var data in dataList) {
    final int month = data[dataType2].toDate().month;
    totalList.add({"index": month, "amount": data[dataType]});
    totalList.sort((a, b) => a["index"].compareTo(b["index"]));
  }
}


