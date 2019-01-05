import 'package:intl/intl.dart';

String formatCurrency(dynamic amount, {String prefix = 'Rp.'}) {
  final NumberFormat formatter = NumberFormat.decimalPattern('id_ID');
  return '$prefix ${formatter.format(amount)}';
}
