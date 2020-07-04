import 'package:expensemanagerapp/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  TransactionList(
      {@required this.transactions, @required this.removeTransaction});

  @override
  Widget build(BuildContext context) {
    print("List is ${transactions.length}");
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text("No Transactions Added yet"),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                elevation: 6,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text(
                                "\$ ${transactions[index].amount.toStringAsFixed(1)}"))),
                  ),
                  title: Text(
                    transactions[index].title,
                  ),
                  subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () {removeTransaction(transactions[index]);},
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
