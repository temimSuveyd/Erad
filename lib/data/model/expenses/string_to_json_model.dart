import 'dart:convert';
import 'dart:developer';

List<Map<String, dynamic>> fromStringToList(List<String>? expenses) {
  List<Map<String, dynamic>> parsedResults = [];

  if (expenses == null || expenses.isEmpty) {
    return parsedResults;
  }

  try {
    for (var element in expenses) {
      // Remove any leading/trailing whitespace and braces
      String cleaned = element.trim().replaceAll(RegExp(r'^{+|}+$'), '');

      // Add quotes to keys without quotes and handle date/number values
      String fixed = cleaned
          .replaceAllMapped(
            RegExp(r'(\w+):'),
            (Match match) => '"${match.group(1)}":',
          )
          .replaceAllMapped(
            RegExp(r'(\d{4}-\d{2}-\d{2}(?: \d{2}:\d{2}:\d{2}\.\d+)?)'),
            (m) => '"${m[1]}"',
          );

      // Wrap in braces to create a valid JSON object
      String jsonObjectString = "{$fixed}";

      Map<String, dynamic> parsedMap =
          jsonDecode(jsonObjectString) as Map<String, dynamic>;
      parsedResults.add(parsedMap);
    }
    return parsedResults;
  } on Exception catch (e) {
    log("Error parsing expenses: $e");
    return [];
  }
}
