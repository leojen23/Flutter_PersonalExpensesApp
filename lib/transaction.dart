import 'package:flutter/foundation.dart'; // this imports the @required decorator which is not in the dart library

class Transaction {
  String id;
  String title;
  double amount;
  DateTime date;


//We use the constructor to build object by passing named arguments
  Transaction(
    //@required specifies that a field is required and will throw an error if data not given for specified field
      {
      @required this.id,
      @required this.title,
      @required this.amount,
      @required this.date
      });
}
