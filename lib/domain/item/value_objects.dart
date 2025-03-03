import 'package:Sepetim/domain/core/failures.dart';
import 'package:Sepetim/domain/core/value_object.dart';
import 'package:Sepetim/domain/core/value_validators.dart';
import 'package:Sepetim/domain/item/value_validators.dart';
import 'package:Sepetim/predefined_variables/helper_functions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class DescriptionBody extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 1000;

  factory DescriptionBody(String input) {
    assert(input != null);
    return DescriptionBody._(validateMaxStringLength(input, maxLength));
  }

  DescriptionBody._(this.value);
}

class Price extends ValueObject<double> {
  @override
  final Either<ValueFailure<double>, double> value;

  factory Price(String input) {
    assert(input != null);
    return Price._(validatePrice(input));
  }

  String fittedPrice(BuildContext context) {
    double price = getOrCrash();
    String suffix = '';

    if (price >= 1e6) {
      if (price >= 1e9) {
        if (price >= 1e12) {
          price /= 1e12;
          suffix = translate(context, 'trillion');
        } else {
          price /= 1e9;
          suffix = translate(context, 'billion');
        }
      } else {
        price /= 1e6;
        suffix = translate(context, 'million');
      }
    }

    return '${price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2)} $suffix';
  }

  Price._(this.value);
}

class SelectedIndex extends ValueObject<int> {
  @override
  final Either<ValueFailure<int>, int> value;

  static const maxIndex = 2;

  factory SelectedIndex(int input) {
    assert(input != null);
    return SelectedIndex._(validateSelectedIndex(input, maxIndex));
  }

  SelectedIndex._(this.value);
}
