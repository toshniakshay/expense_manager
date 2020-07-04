import 'package:expensemanagerapp/models/transaction.dart';
import 'package:expensemanagerapp/widgets/chart.dart';
import 'package:expensemanagerapp/widgets/new_transactions.dart';
import 'package:expensemanagerapp/widgets/transactionLists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.lime,
          errorColor: Colors.redAccent,
          fontFamily: "OpenSans",
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 20.0,
                    color: Colors.black87,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  List<Transaction> _transactions = [];

  List<Transaction> get recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _addTransaction(String title, double amount, DateTime txDate) {
    final transactionToAdd = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: txDate);

    setState(() {
      _transactions.add(transactionToAdd);
      print("Transaction added to the list : ${_transactions.length}");
    });
  }

  void deleteTransaction(Transaction transaction) {
    setState(() {
      _transactions.remove(transaction);
    });
  }

  void _startAddTransactionProcess(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return NewTransation(onAddTransactionClick: _addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final appbar = AppBar(
      title: Text("Personal Expenses"),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddTransactionProcess(context)),
      ],
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height - MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(recentTransactions: recentTransactions)),
              Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height- MediaQuery.of(context).padding.top) *
                    0.7,
                child: TransactionList(
                  transactions: _transactions,
                  removeTransaction: deleteTransaction,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddTransactionProcess(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
    );
  }
}
