import 'package:flutter/material.dart';

import './widgets/Transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personnal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18)),

        //set the Appbar them. we assign a new text them for our appbar and base it on the default text them and overwrite it with custom value
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // text edidting controller can be assigned to textField
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'New shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'New T-shirt', amount: 35.99, date: DateTime.now()),
    // Transaction(
    //     id: 't3', title: 'New Computer', amount: 1669.99, date: DateTime.now()),
    // Transaction(
    //     id: 't4', title: 'Food shopping', amount: 125.30, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    //the Where() method can be accessed from every List widgets.
    // it allows us to run a function on every item in the list. if the function return true, the functions is kept in a newly returned list
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
        ));
    }).toList();
  }

// function that will create and add a new transaction to the transactionlist
  void _addNewTransaction(String txTitle, double txAmount) {
    //we instanciate a new transaction giving it all the required property values
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );

// we set the state with the new transaction by adding it to the list of transaction using the method add() and passing the new transaction instance as argument
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    // CTX is passed so the builder can use it to create the sheet
    // uses the context object to show the modal sheet.
    //builder is a functinoo that returns the widget that should be inside the modal sheet
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        // to catch
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
        centerTitle: true,
        title: Text(
          'Personnal Expenses',
        ),
      ),

      // we wrap Column in a scroll view
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
