import 'package:easy_localization/easy_localization.dart';

extension DateTimeX on DateTime {
  String toFormattedDate({String? format}) {
    return DateFormat(format ?? 'dd/MM/yyyy').format(this);
  }
}
