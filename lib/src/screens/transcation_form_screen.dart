import 'package:expense_tracker/src/models/transcation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TranscationForm extends StatefulWidget {
  final Function(Transcation) onSave;

  const TranscationForm({Key key, this.onSave}) : super(key: key);

  @override
  _TranscationFormState createState() => _TranscationFormState();
}

class _TranscationFormState extends State<TranscationForm> {
  final _amountController = TextEditingController();
  final _descController = TextEditingController();
  final _scaffoldState = GlobalKey<ScaffoldState>();
  DateTime _date;

  @override
  void initState() {
    super.initState();
    _date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text('Add Transcation'),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter amount',
                  ),
                ),
                TextField(
                  controller: _descController,
                  decoration: InputDecoration(
                    labelText: 'Enter description',
                  ),
                ),
                InputDecorator(
                  child: InkWell(
                    child: Text('${DateFormat.yMMMEd().format(_date)}'),
                    onTap: _pickDate,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Enter Date',
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: _submit,
                    child: Text('Add Transcation'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_amountController.text.trim() == "") {
      _showMsg('Transcation amount is required.');
    } else if (_descController.text.trim().isEmpty) {
      _showMsg('Transcation description is required.');
    } else {
      final _transcation = Transcation(
        amount: double.tryParse(_amountController.text) ?? 0.0,
        description: _descController.text.trim(),
        date: _date,
      );
      widget.onSave(_transcation);
      Navigator.pop(context);
    }

    //Navigator.pop(context);
  }

  _showMsg(String msg) {
    _scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () => _scaffoldState.currentState.hideCurrentSnackBar(),
          textColor: Colors.white,
        ),
      ),
    );
  }

  void _pickDate() async {
    final _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (_pickedDate != null) _date = _pickedDate;
    setState(() {});
  }
}
