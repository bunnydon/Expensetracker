import 'package:expense_tracker/models/transcation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text("No expenses added yet!", style: TextStyle()),
                  SizedBox(
                    height: constraints.maxHeight * 0.03,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      "assets/images/box.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (ctx, index) {
              return Card(
                  child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FittedBox(
                      child: Text(
                        '\$' + transaction[index].itemPrice.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  transaction[index].itemName,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  DateFormat.yMMMEd().format(transaction[index].itemDate),
                  style: Theme.of(context).textTheme.title,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.grey[500],
                  ),
                  onPressed: () {
                    deleteTx(transaction[index].id);
                  },
                ),
              ));
            },
          );
  }
}

// Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      Container(
//                        child: Text(
//                          '\$' + transaction[index].itemPrice.toString(),
//                          style: TextStyle(
//                            color: Theme.of(context).primaryColor,
//                            fontSize: 25.0,
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                        decoration: BoxDecoration(
//                            border: Border.all(
//                              color: Colors.green,
//                              width: 2,
//                            ),
//                            borderRadius: BorderRadius.circular(10.0)),
//                        margin:
//                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                        padding: EdgeInsets.all(5.0),
//                      ),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text(
//                            transaction[index].itemName,
//                            style: Theme.of(context).textTheme.title,
//                          ),
//                          Text(
//                            DateFormat.yMMMEd()
//                                .format(transaction[index].itemDate),
//                            style: Theme.of(context).textTheme.title,
//                          ),
//                        ],
//                      )
//                    ],
//                  ),
