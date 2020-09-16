import 'package:flutter/material.dart';

// date and time formatting package
import 'package:intl/intl.dart';

import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
//We create a List widget of transaction widgets called transactions
  final List<Transaction> transactions = [
    Transaction(
        id: 't1', title: 'New shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'New T-shirt', amount: 35.99, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'New Computer', amount: 1669.99, date: DateTime.now()),
    Transaction(
        id: 't4', title: 'Food shopping', amount: 125.30, date: DateTime.now()),
  ];

  String titleInput;
  String amountInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              elevation: 5,
              color: Colors.blue,
              child: Text("chart"),
            ),
          ),

        //INPUT AREA -------------------------------------------------------------------------------

          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // Textfield Widget is responsible for receiving data user input
                  //the onchanged listener will fire with every keystroke
                  //onSumbmit will fire on the submit
                  TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      onChanged: (val) {
                        titleInput = val;
                      }),
                  TextField(
                      decoration: InputDecoration(labelText: 'Amount'),
                      onChanged: (val) {
                        amountInput = val;
                      }),
                  FlatButton(
                    child: Text('add Transaction'),
                    onPressed: () {
                      print(amountInput);
                      print(titleInput);
                    }, 
                    textColor: Colors.purple,
                  ),
                ],
              ),
            ),
          ),

//we want to map trought our transactions List to create a card widget for each transaction
// the functin in map() gets executed on every item in the array
          Column(
            children: transactions.map((tx) {
              return Card(
                  child: Row(
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Text(
                      //String interpolation syntax below
                      '\£${tx.amount}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                        width: 2,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        tx.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        // see documentation for formatting date on pub.dev (Intl package)
                        // DateFormat('yyyy/MM/dd').format(tx.date),
                        DateFormat.yMMMd().format(tx.date),
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      )
                    ],
                  )
                ],
              ));
            }).toList(),
          ),
        ],
      ),
    );
  }
}
