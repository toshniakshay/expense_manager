import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendinPercentage;

  ChartBar(
      {@required this.label,
      @required this.spendingAmount,
      @required this.spendinPercentage});

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(height: constraints.maxHeight * 0.15,child: FittedBox(child: Text("\$${spendingAmount.toStringAsFixed(0)}"))),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendinPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(height: constraints.maxHeight * 0.15,child: FittedBox(child: Text(label)))
        ],
      );
    });

  }
}
