import 'package:budman_app/models/Account.dart';

import 'Expenses.dart';
import 'Goal.dart';

class User{
  String name;
  String email;
  String password;
  String contact;
  String token;
  List<Expenses> expenses;
  List<Account> accounts;
  List<Goal> goals;
  int salary;

  User(this.name, this.email, this.password, this.contact, this.token, this.expenses,this.salary,this.accounts,this.goals);

}