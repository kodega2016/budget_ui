import 'package:expense_tracker/src/constants/days.dart';
import 'package:expense_tracker/src/models/transcation.dart';
import 'package:expense_tracker/src/screens/transcation_form_screen.dart';
import 'package:expense_tracker/src/widgets/chart_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _transcations = <Transcation>[];

  Map get _getData {
    Map _data = <String, double>{};
    for (var transcation in _transcations) {
      if (_data[DateFormat.E().format(transcation.date)] == null) {
        _data[DateFormat.E().format(transcation.date)] = transcation.amount;
      } else {
        _data[DateFormat.E().format(transcation.date)] += transcation.amount;
      }
    }

    return _data;
  }

  double get total => _getData.values.fold(0, (a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TranscationForm(
                    onSave: (transcation) {
                      _transcations.add(transcation);
                      setState(() {});
                    },
                  ),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...days.map((e) {
                      var _height =
                          total == 0 ? 0.0 : (_getData[e] ?? 0.0) / total;
                      return ChartItem(day: e, height: _height);
                    }).toList(),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Card(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _transcations.length,
                  itemBuilder: (context, i) {
                    final _transcation = _transcations[i];
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      key: Key(i.toString()),
                      background: Container(color: Colors.red),
                      onDismissed: (dir) {
                        _transcations.removeAt(i);
                        setState(() {});
                      },
                      child: ListTile(
                        title: Row(
                          children: [
                            Text('Rs.${_transcation.amount}'),
                            Spacer(),
                            Text(
                                '${DateFormat.yMMMEd().format(_transcation.date)}'),
                          ],
                        ),
                        subtitle: Text(_transcation.description),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
