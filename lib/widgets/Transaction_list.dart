import 'package:flutter/material.dart';
import '../models/transaction.dart';

// date and time formatting package
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;

  TransactionList(this.transactions);

  //We create a List widget of transaction widgets called transactions
  @override
  //we want to map trought our transactions List to create a card widget for each transaction
  // the functin in map() gets executed on every item in the array
  Widget build(BuildContext context) {


    //list view is a Column with a scroll view and an infinite height. it doesn't hae a fixed height because it is scrollable and has to be a larger than a screen size
     return Container(
       height: 1000,
       
       
       child: transactions.isEmpty ? Column (
         children: <Widget> [
           Text('No transactions added yet'),
           SizedBox(height:30), // we use Sizedbox to create an empty space between widgets
          Container(height: 300,
          child: Image.asset('images/waiting.png', fit: BoxFit.cover,))
         ],
         
       ): ListView.builder(
         // itemCount will determine the number of times the builder will run the building function on each items in the list.
         // in this case we use our transactions list and the number of items in the list
         itemCount: transactions.length,

          // the builder method requires an itembuilder: ittakes a function with arguments (context, index) provided by Flutter
          //it return card items and uses the index to locate information about each itmes in the list
         itemBuilder:(BuildContext context, int index) {
           return Card(
              child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Text(
                  //String interpolation syntax below
                  //toStringAsFixed() allows to tell the number of digits we want after the . for decimal values
                  '\£${transactions[index].amount.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                     color: Theme.of(context).primaryColor),
                ),
                decoration: BoxDecoration(
                  border: Border.all(

                    //Theme.of(Context) let us access the theme properties in set in the material App settings
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transactions[index].title,

                    // we use the TextTheme properites from the Theme in the main.dart file
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    // see documentation for formatting date on pub.dev (Intl package)
                    // DateFormat('yyyy/MM/dd').format(tx.date),
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  )
                ],
              )
            ],
          ), 
          );

         },
    ),
     );
  }
}



//this is an example on how to map through a list of items
// children: transactions.map((tx) {
        //   return Card(
        //       child: Row(
        //     children: <Widget>[
        //       Container(
        //         margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        //         child: Text(
        //           //String interpolation syntax below
        //           '\£${tx.amount}',
        //           style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 20,
        //               color: Colors.purple),
        //         ),
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             color: Colors.purple,
        //             width: 2,
        //           ),
        //         ),
        //         padding: EdgeInsets.all(10),
        //       ),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           Text(
        //             tx.title,
        //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        //           ),
        //           Text(
        //             // see documentation for formatting date on pub.dev (Intl package)
        //             // DateFormat('yyyy/MM/dd').format(tx.date),
        //             DateFormat.yMMMd().format(tx.date),
        //             style: TextStyle(color: Colors.grey, fontSize: 13),
        //           )
        //         ],
        //       )
        //     ],
        //   ), 
        //   );
          
        // }).toList(),
