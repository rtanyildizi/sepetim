// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'password_visibility_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$PasswordVisibilityEventTearOff {
  const _$PasswordVisibilityEventTearOff();

  _VisibilityChanged visibilityChanged() {
    return const _VisibilityChanged();
  }
}

// ignore: unused_element
const $PasswordVisibilityEvent = _$PasswordVisibilityEventTearOff();

mixin _$PasswordVisibilityEvent {}

abstract class $PasswordVisibilityEventCopyWith<$Res> {
  factory $PasswordVisibilityEventCopyWith(PasswordVisibilityEvent value,
          $Res Function(PasswordVisibilityEvent) then) =
      _$PasswordVisibilityEventCopyWithImpl<$Res>;
}

class _$PasswordVisibilityEventCopyWithImpl<$Res>
    implements $PasswordVisibilityEventCopyWith<$Res> {
  _$PasswordVisibilityEventCopyWithImpl(this._value, this._then);

  final PasswordVisibilityEvent _value;
  // ignore: unused_field
  final $Res Function(PasswordVisibilityEvent) _then;
}

abstract class _$VisibilityChangedCopyWith<$Res> {
  factory _$VisibilityChangedCopyWith(
          _VisibilityChanged value, $Res Function(_VisibilityChanged) then) =
      __$VisibilityChangedCopyWithImpl<$Res>;
}

class __$VisibilityChangedCopyWithImpl<$Res>
    extends _$PasswordVisibilityEventCopyWithImpl<$Res>
    implements _$VisibilityChangedCopyWith<$Res> {
  __$VisibilityChangedCopyWithImpl(
      _VisibilityChanged _value, $Res Function(_VisibilityChanged) _then)
      : super(_value, (v) => _then(v as _VisibilityChanged));

  @override
  _VisibilityChanged get _value => super._value as _VisibilityChanged;
}

class _$_VisibilityChanged implements _VisibilityChanged {
  const _$_VisibilityChanged();

  @override
  String toString() {
    return 'PasswordVisibilityEvent.visibilityChanged()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _VisibilityChanged);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _VisibilityChanged implements PasswordVisibilityEvent {
  const factory _VisibilityChanged() = _$_VisibilityChanged;
}

class _$PasswordVisibilityStateTearOff {
  const _$PasswordVisibilityStateTearOff();

  _PasswordVisibilityState call({@required bool isVisible}) {
    return _PasswordVisibilityState(
      isVisible: isVisible,
    );
  }
}

// ignore: unused_element
const $PasswordVisibilityState = _$PasswordVisibilityStateTearOff();

mixin _$PasswordVisibilityState {
  bool get isVisible;

  $PasswordVisibilityStateCopyWith<PasswordVisibilityState> get copyWith;
}

abstract class $PasswordVisibilityStateCopyWith<$Res> {
  factory $PasswordVisibilityStateCopyWith(PasswordVisibilityState value,
          $Res Function(PasswordVisibilityState) then) =
      _$PasswordVisibilityStateCopyWithImpl<$Res>;
  $Res call({bool isVisible});
}

class _$PasswordVisibilityStateCopyWithImpl<$Res>
    implements $PasswordVisibilityStateCopyWith<$Res> {
  _$PasswordVisibilityStateCopyWithImpl(this._value, this._then);

  final PasswordVisibilityState _value;
  // ignore: unused_field
  final $Res Function(PasswordVisibilityState) _then;

  @override
  $Res call({
    Object isVisible = freezed,
  }) {
    return _then(_value.copyWith(
      isVisible: isVisible == freezed ? _value.isVisible : isVisible as bool,
    ));
  }
}

abstract class _$PasswordVisibilityStateCopyWith<$Res>
    implements $PasswordVisibilityStateCopyWith<$Res> {
  factory _$PasswordVisibilityStateCopyWith(_PasswordVisibilityState value,
          $Res Function(_PasswordVisibilityState) then) =
      __$PasswordVisibilityStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isVisible});
}

class __$PasswordVisibilityStateCopyWithImpl<$Res>
    extends _$PasswordVisibilityStateCopyWithImpl<$Res>
    implements _$PasswordVisibilityStateCopyWith<$Res> {
  __$PasswordVisibilityStateCopyWithImpl(_PasswordVisibilityState _value,
      $Res Function(_PasswordVisibilityState) _then)
      : super(_value, (v) => _then(v as _PasswordVisibilityState));

  @override
  _PasswordVisibilityState get _value =>
      super._value as _PasswordVisibilityState;

  @override
  $Res call({
    Object isVisible = freezed,
  }) {
    return _then(_PasswordVisibilityState(
      isVisible: isVisible == freezed ? _value.isVisible : isVisible as bool,
    ));
  }
}

class _$_PasswordVisibilityState implements _PasswordVisibilityState {
  const _$_PasswordVisibilityState({@required this.isVisible})
      : assert(isVisible != null);

  @override
  final bool isVisible;

  @override
  String toString() {
    return 'PasswordVisibilityState(isVisible: $isVisible)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PasswordVisibilityState &&
            (identical(other.isVisible, isVisible) ||
                const DeepCollectionEquality()
                    .equals(other.isVisible, isVisible)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(isVisible);

  @override
  _$PasswordVisibilityStateCopyWith<_PasswordVisibilityState> get copyWith =>
      __$PasswordVisibilityStateCopyWithImpl<_PasswordVisibilityState>(
          this, _$identity);
}

abstract class _PasswordVisibilityState implements PasswordVisibilityState {
  const factory _PasswordVisibilityState({@required bool isVisible}) =
      _$_PasswordVisibilityState;

  @override
  bool get isVisible;
  @override
  _$PasswordVisibilityStateCopyWith<_PasswordVisibilityState> get copyWith;
}
