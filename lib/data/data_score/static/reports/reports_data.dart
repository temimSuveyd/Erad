import 'package:erad/data/model/reports/reports_chart_cards_model.dart';
import 'package:flutter/material.dart';

List<ReportsChartCardsModel> reportsChartsData = [
  ReportsChartCardsModel(
    title: "إجمالي أرباحي",
    value: [],
    color: Colors.green, // Green
  ),
  ReportsChartCardsModel(
    title: "إجمالي ديوني",
    value: [],
    color: Colors.red, // Red
  ),
  ReportsChartCardsModel(
    title: "إجمالي ديون الموردين",
    value: [],
    color: Colors.blue, // Blue
  ),
  ReportsChartCardsModel(
    title: "إجمالي مصاريفي",
    value: [],
    color: Colors.orange, // Orange
  ),
  ReportsChartCardsModel(
    title: "إجمالي المبالغ المسحوبة",
    value: [],
    color: Colors.purple, // Purple
  ),
];
