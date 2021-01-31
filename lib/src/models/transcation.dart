import 'package:meta/meta.dart';

class Transcation {
  final double amount;
  final String description;
  final DateTime date;

  Transcation({
    @required this.amount,
    @required this.description,
    @required this.date,
  });

  String toString() {
    super.toString();
    return 'Amount:$amount Description:$description';
  }
}
