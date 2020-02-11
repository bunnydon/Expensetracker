import 'package:expense_tracker/models/transcation.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // this method ensures only to use portrait mode

//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]).then((_) {
//    runApp(MyApp());
//  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpensePage(),
      theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: "Quicksand",
          textTheme: TextTheme(
              title: TextStyle(
            fontFamily: "Quicksand",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )),
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  title: TextStyle(
            fontFamily: "Lato",
            fontSize: 20,
          )))),
    );
  }
}

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  List<Transaction> _userTransation = [
//    Transaction(
//        itemName: "Mobile", itemPrice: 120.50, itemDate: DateTime.now()),
//    Transaction(
//        itemName: "Jacket", itemPrice: 110.50, itemDate: DateTime.now()),
//    Transaction(itemName: "Watch", itemPrice: 130.50, itemDate: DateTime.now()),
//    Transaction(
//        itemName: "Kobe Jersey", itemPrice: 150.50, itemDate: DateTime.now()),
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _userTransation.where((tx) {
      return tx.itemDate.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txName, double txPrice, DateTime txDate) {
    final NewTx = Transaction(
        itemName: txName,
        itemPrice: txPrice,
        itemDate: txDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransation.add(NewTx);
    });
  }

  //this function helps you delete the transacations

  void _deleteTransactions(String id) {
    setState(() {
      _userTransation.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _showAddTransaction(BuildContext bCtx) {
    showModalBottomSheet(
        context: bCtx,
        builder: (ctx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      backgroundColor: Colors.green,
      title: Text(
        "Expense Tracker",
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            _showAddTransaction(context);
          },
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Show Chart",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                      value: _showChart,
                      onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      })
                ],
              ),
            if (!isLandscape)
              Container(
                  height: (MediaQuery.of(context).size.height * 0.3) -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top,
                  child: Chart(_recentTransaction)),
            if (!isLandscape)
              Container(
                  height: (MediaQuery.of(context).size.height * 0.7) -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top,
                  child: TransactionList(_userTransation, _deleteTransactions)),
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height * 0.7) -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top,
                      child: Chart(_recentTransaction))
                  : Container(
                      height: (MediaQuery.of(context).size.height * 0.7) -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top,
                      child: TransactionList(
                          _userTransation, _deleteTransactions)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.black,
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          _showAddTransaction(context);
        },
      ),
    );
  }
}
