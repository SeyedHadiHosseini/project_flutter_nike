import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

const defaultScrollPhysics = BouncingScrollPhysics();

extension PeiceLable on int {
  String get withPriceLabel => this > 0 ? '$separateByComma تومان' : 'رایگان';

  String get separateByComma {
    final numberFromat = NumberFormat.decimalPattern();
    return numberFromat.format(this);
  }
}
