import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  // text edidting controller can be assigned to textField
  final Function addTx;

  // NewTransaction({Key key, this.addTx}) : super(key: key);
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; //stop the execution of the function
    }

    // widget. lets us acces the class methods or properties from another class and is only available in STATE CLASSES
    //widget is a special property that gives you acesss to the properties of your widget
    widget.addTx(enteredTitle, enteredAmount);

  // we use Navigator pop() method to close the modal sheet after userinput
  // of (context) is used to get access to the right navigator or to give it some metadata
  //context is a special property available classwide which gives you access to the context of your widget
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                //the controllers are connected to the texfield and listen to userinput and save it in variable
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController
                //below an alternative ways of dealing with userInput
                // onChanged: (val) {
                //   titleInput = val;
                // }
                ),

            TextField(
              //keyboardtype enable the number keyboard when user input is prompted
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              onSubmitted: (_) =>
                  submitData(), // the underscore as argument in the anonymous function mean that i give it an arugment but i don 't care about what it is
              // onSubmitted takes an anonymous function
            ),

            FlatButton(
              child: Text('add Transaction'),
              onPressed: submitData,
              textColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
