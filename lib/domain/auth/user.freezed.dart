// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {@required UniqueId id,
      @required SignInType signInType,
      @required Option<String> emailOption}) {
    return _User(
      id: id,
      signInType: signInType,
      emailOption: emailOption,
    );
  }
}

// ignore: unused_element
const $User = _$UserTearOff();

mixin _$User {
  UniqueId get id;
  SignInType get signInType;
  Option<String> get emailOption;

  $UserCopyWith<User> get copyWith;
}

abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call({UniqueId id, SignInType signInType, Option<String> emailOption});

  $SignInTypeCopyWith<$Res> get signInType;
}

class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object id = freezed,
    Object signInType = freezed,
    Object emailOption = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as UniqueId,
      signInType:
          signInType == freezed ? _value.signInType : signInType as SignInType,
      emailOption: emailOption == freezed
          ? _value.emailOption
          : emailOption as Option<String>,
    ));
  }

  @override
  $SignInTypeCopyWith<$Res> get signInType {
    if (_value.signInType == null) {
      return null;
    }
    return $SignInTypeCopyWith<$Res>(_value.signInType, (value) {
      return _then(_value.copyWith(signInType: value));
    });
  }
}

abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call({UniqueId id, SignInType signInType, Option<String> emailOption});

  @override
  $SignInTypeCopyWith<$Res> get signInType;
}

class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object id = freezed,
    Object signInType = freezed,
    Object emailOption = freezed,
  }) {
    return _then(_User(
      id: id == freezed ? _value.id : id as UniqueId,
      signInType:
          signInType == freezed ? _value.signInType : signInType as SignInType,
      emailOption: emailOption == freezed
          ? _value.emailOption
          : emailOption as Option<String>,
    ));
  }
}

class _$_User implements _User {
  const _$_User(
      {@required this.id,
      @required this.signInType,
      @required this.emailOption})
      : assert(id != null),
        assert(signInType != null),
        assert(emailOption != null);

  @override
  final UniqueId id;
  @override
  final SignInType signInType;
  @override
  final Option<String> emailOption;

  @override
  String toString() {
    return 'User(id: $id, signInType: $signInType, emailOption: $emailOption)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.signInType, signInType) ||
                const DeepCollectionEquality()
                    .equals(other.signInType, signInType)) &&
            (identical(other.emailOption, emailOption) ||
                const DeepCollectionEquality()
                    .equals(other.emailOption, emailOption)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(signInType) ^
      const DeepCollectionEquality().hash(emailOption);

  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);
}

abstract class _User implements User {
  const factory _User(
      {@required UniqueId id,
      @required SignInType signInType,
      @required Option<String> emailOption}) = _$_User;

  @override
  UniqueId get id;
  @override
  SignInType get signInType;
  @override
  Option<String> get emailOption;
  @override
  _$UserCopyWith<_User> get copyWith;
}
