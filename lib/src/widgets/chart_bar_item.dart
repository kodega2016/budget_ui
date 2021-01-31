import 'package:flutter/material.dart';

class ChartItem extends StatelessWidget {
  final String day;
  final double height;

  const ChartItem({Key key, this.day, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 140,
          child: Stack(
            children: [
              Container(
                width: 16,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              FractionallySizedBox(
                heightFactor: height,
                child: Container(
                  width: 16,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(4),
          child: Text(day),
        ),
      ],
    );
  }
}
