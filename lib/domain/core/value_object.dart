import 'package:Sepetim/domain/core/errors.dart';
import 'package:Sepetim/domain/core/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  /// Throws [UnexptectedValueError] containing the [ValueFailure]
  T getOrCrash() {
    return value.fold((f) => throw UnexpectedValueError, id);
  }

  Either<ValueFailure<dynamic>, Unit> get failureOrUnit => value.fold(
        (f) => left(f),
        (_) => right(unit),
      );

  bool get isValid => value.isRight();

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ValueObject<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}
