import 'package:erad/data/model/withdrawn_fund/total_amount_card_model.dart';
import 'package:flutter/material.dart';

List<TotalAmountCardModel> totalAmountCards = [
  TotalAmountCardModel(
    icon: Icons.trending_up_rounded,
    color: Colors.green, // Uyumlu ikon rengi
    title: "مجمل أرباحي",
    showDropDownMenu: false,
    showDebtCheck: true,
  ),
  TotalAmountCardModel(
    icon: Icons.account_balance_wallet_rounded,
    color: Colors.red, // Uyumlu ikon rengi
    title: "ديوني",
    showDropDownMenu: false,
    showDebtCheck: false,
  ),
  TotalAmountCardModel(
    icon: Icons.people_alt_rounded,
    color: Colors.deepOrange, // Uyumlu ikon rengi
    title: "ديون العملاء",
    showDropDownMenu: false,
    showDebtCheck: false,
  ),
  TotalAmountCardModel(
    icon: Icons.money_off_csred_rounded,
    color: Colors.teal, // Uyumlu ikon rengi
    title: "مصاريفي",
    showDropDownMenu: false,
    showDebtCheck: false,
  ),

  TotalAmountCardModel(
    icon: Icons.outbound_rounded,
    color: Colors.purple, // Uyumlu ikon rengi
    title: "مجمل سحب الأموال",
    showDropDownMenu: true,
    showDebtCheck: false,
  ),
];
