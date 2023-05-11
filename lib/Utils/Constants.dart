import 'dart:ui';

import 'package:flutter/material.dart';

const String loginUri="https://fixed-sunny-wood.glitch.me/login";
const String registerUri="https://fixed-sunny-wood.glitch.me/register";
const String getUserUri="https://fixed-sunny-wood.glitch.me/getUser";
const String addExpenseUri="https://fixed-sunny-wood.glitch.me/addExpense";
const String addCreditUri="https://fixed-sunny-wood.glitch.me/creditSalary";
const String removeExpenseUri="https://fixed-sunny-wood.glitch.me/removeExpense";
const String editExpenseUri="https://fixed-sunny-wood.glitch.me/editExpense";
const String changePasswordUri="https://fixed-sunny-wood.glitch.me/changePassword";
const String updateProfileUri="https://fixed-sunny-wood.glitch.me/updateProfile";
const String addAccountUri="https://fixed-sunny-wood.glitch.me/addAccount";
const String removeAccountUri="https://fixed-sunny-wood.glitch.me/deleteAccount";
const String addGoalUri="https://fixed-sunny-wood.glitch.me/addGoal";
const String addGoalAmountUri="https://fixed-sunny-wood.glitch.me/addSavedAmount";
const String changeGoalStatusUri="https://fixed-sunny-wood.glitch.me/changeGoalStatus";

const colorCardBlue=Color(0xff80c4ff);
const colorCardPurple=Color(0xffb380ff);
const colorCardGreen=Color(0xff80ff80);
const colorCardRed=Color(0xFFFF8080);

const colorCardBlueDark=Color(0xff2b9bfd);
const colorCardPurpleDark=Color(0xff7227fc);
const colorCardGreenDark=Color(0xff24fc24);
const colorCardRedDark=Color(0xFFFF2929);

const Map<int,List<String>> categories={
  0:["Bills(Electricity/Water/Gas)","Bills"],
  1:["Food","Food"],
  2:["Medical","Medical"],
  3:["Travel","Travel"],
  4:["Others","Others"]
};
const Map<int,String> accountTypes={
  0:"Current",
  1:"Savings",
  2:"Cash",
  3:"Investment",
  4:"Others"
};
const Map<int,Color> categoriesByColor={
  0:Colors.red,
  1:Colors.blue,
  2:Colors.green,
  3:Colors.purple,
  4:Colors.yellow,
};
const List<String>MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
