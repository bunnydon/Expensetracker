import 'package:expense_tracker/transcation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          splashColor: Colors.black45,
          onPressed: () {},
          child: Icon(
            Icons.add,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Expense tracker",
          ),
          centerTitle: true,
        ),
        body: ExpensePage(),
      ),
    );
  }
}

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  List<Transaction> transaction = [
    Transaction(
        itemName: "Mobile", itemPrice: 120.50, itemDate: DateTime.now()),
    Transaction(
        itemName: "Jacket", itemPrice: 110.50, itemDate: DateTime.now()),
    Transaction(itemName: "Watch", itemPrice: 130.50, itemDate: DateTime.now()),
  ];

  String itemName;
  String itemprice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Card(
            child: Text(
              "Expense Tracker Chart",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            elevation: 5.0,
          ),
        ),
        Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  onChanged: (Value) {
                    itemName = Value;
                  },
                  cursorColor: Colors.green,
                  decoration: InputDecoration(labelText: "Item Name"),
                ),
                TextField(
                  onChanged: (val) {
                    itemprice = (val);
                  },
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                    labelText: "Item Price",
                  ),
                ),
                RaisedButton(
                  onLongPress: () {
                    setState(() {
                      transaction.add(
                        Transaction(
                          itemPrice: double.parse(itemprice),
                          itemName: itemName,
                          itemDate: DateTime.now(),
                        ),
                      );
                    });
                  },
                  child: Text(
                    "Add Transactions",
                    textAlign: TextAlign.center,
                  ),
                  textColor: Colors.black,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
        Column(
          children: transaction.map((tx) {
            return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Text(
                      '\$' + tx.itemPrice.toString(),
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    padding: EdgeInsets.all(5.0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        tx.itemName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(tx.itemDate),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
