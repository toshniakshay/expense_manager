import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class NewTransation extends StatefulWidget {
  final Function onAddTransactionClick;

  NewTransation({@required this.onAddTransactionClick});

  @override
  _NewTransationState createState() => _NewTransationState();
}

class _NewTransationState extends State<NewTransation> {
  final _titleTextController = TextEditingController();
  final _amountEditingController = TextEditingController();
  DateTime _pickedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        _pickedDate = value;
      });

    });
  }

  void _submitData() {
    final enteredTitle = _titleTextController.text;
    final amountEntered = double.parse(_amountEditingController.text);

    if (enteredTitle.isEmpty || amountEntered <= 0 || _pickedDate == null) {
      return;
    }

    widget.onAddTransactionClick(
      enteredTitle,
      amountEntered,
      _pickedDate
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                maxLines: 1,
                decoration: InputDecoration(labelText: "Title"),
                controller: _titleTextController,
              ),
              TextField(
                maxLines: 1,
                decoration: InputDecoration(labelText: "Amount"),
                controller: _amountEditingController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _pickedDate == null
                          ? "No Date Chosen!"
                          : DateFormat.yMMMd().format(_pickedDate),
                    ),
                    FlatButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          "Choose Date",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _submitData,
                  child: Text(
                    "Add Transaction",
                    style: TextStyle(color: Colors.black87),
                  ),
                  textColor: Colors.purple,
                ),
              ),
            ],
          ),
        ));
  }
}
