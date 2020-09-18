

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        // FittedBox makes the text widget shrink
        FittedBox(child: Text('\£${spendingAmount.toStringAsFixed(0)}')),

        // SizedBox is used to generate space between elements
        SizedBox (
          height:4,
          ),

        Container(
          height: 60,
          width: 10,
          //the stack widget allows you to place elements on the top of each other, not like a column but overlapping each other
          child: Stack(
            children: <Widget> [

              Container(
                decoration: BoxDecoration(

                  // Color enum has a constructor called from RGBO from which you can adjust the opacity
                  color:Color.fromRGBO(220, 220, 200, 1),
                  border: Border.all(
                    color:Colors.grey, 
                    width:1.0),
                  borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // the FractionnallySizebox takes a fraction of the size of anohter container, we pass a value to the heightFactor
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal, 
                child: Container(
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          )
          ),

        SizedBox (
          height:5,
        ),

        Text(label),
      ],
    );
  }
}
