import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  // final Chart({Key key, this.recentTransactions}) : super(key: key);

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);
  // Chart(this.recentTransactions);

// getters are properties calculated dynamically

  List<Map<String, Object>> get groupedTransactionValues {
    //.generate() generates a new list , it takes a length and function that will received the index
    return List.generate(7, (index) {
      //Datetime.now() is today day, to get the previous days of the week, we use the substract method to substrace the number of days
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      // we sum up the transaction from the past week.
      var totalSum = 0.0;

      // DART loop syntax example: for (var tx in recentTransactions)

      for (var i = 0; i < recentTransactions.length; i++) {
        //we can use the intl package to access DateTime.now() information
        //NOITE: The DateTime.now() is an object that combine date and timestamps together. Therefore we must never compare the Date.time().now( ) itself but access its properties to compare them.
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      // Dateformat.E is a shortcut to get the week day letter
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    //the fold() method allows us to change a list to another type. it take a starting value parametre & a function
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
      //we need to return a new value to be added
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(  // the Padding widgets is a container that is there for padding purposes only
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              // with Flexible every items has the same space available
                fit:FlexFit.tight, // the child can 't grow and take no more space than the assigned size
                child: ChartBar(
                data['day'], 
                data['amount'], 
              totalSpending == 0.0 ? 0.0 : (data['amount']as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
