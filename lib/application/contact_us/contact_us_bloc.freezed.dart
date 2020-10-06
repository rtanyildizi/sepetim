// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'contact_us_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ContactUsEventTearOff {
  const _$ContactUsEventTearOff();

// ignore: unused_element
  _EmailMessageChanged emailMessageChanged(String emailMessage) {
    return _EmailMessageChanged(
      emailMessage,
    );
  }

// ignore: unused_element
  _EmailSent emailSent() {
    return const _EmailSent();
  }
}

/// @nodoc
// ignore: unused_element
const $ContactUsEvent = _$ContactUsEventTearOff();

/// @nodoc
mixin _$ContactUsEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result emailMessageChanged(String emailMessage),
    @required Result emailSent(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result emailMessageChanged(String emailMessage),
    Result emailSent(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result emailMessageChanged(_EmailMessageChanged value),
    @required Result emailSent(_EmailSent value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result emailMessageChanged(_EmailMessageChanged value),
    Result emailSent(_EmailSent value),
    @required Result orElse(),
  });
}

/// @nodoc
abstract class $ContactUsEventCopyWith<$Res> {
  factory $ContactUsEventCopyWith(
          ContactUsEvent value, $Res Function(ContactUsEvent) then) =
      _$ContactUsEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ContactUsEventCopyWithImpl<$Res>
    implements $ContactUsEventCopyWith<$Res> {
  _$ContactUsEventCopyWithImpl(this._value, this._then);

  final ContactUsEvent _value;
  // ignore: unused_field
  final $Res Function(ContactUsEvent) _then;
}

/// @nodoc
abstract class _$EmailMessageChangedCopyWith<$Res> {
  factory _$EmailMessageChangedCopyWith(_EmailMessageChanged value,
          $Res Function(_EmailMessageChanged) then) =
      __$EmailMessageChangedCopyWithImpl<$Res>;
  $Res call({String emailMessage});
}

/// @nodoc
class __$EmailMessageChangedCopyWithImpl<$Res>
    extends _$ContactUsEventCopyWithImpl<$Res>
    implements _$EmailMessageChangedCopyWith<$Res> {
  __$EmailMessageChangedCopyWithImpl(
      _EmailMessageChanged _value, $Res Function(_EmailMessageChanged) _then)
      : super(_value, (v) => _then(v as _EmailMessageChanged));

  @override
  _EmailMessageChanged get _value => super._value as _EmailMessageChanged;

  @override
  $Res call({
    Object emailMessage = freezed,
  }) {
    return _then(_EmailMessageChanged(
      emailMessage == freezed ? _value.emailMessage : emailMessage as String,
    ));
  }
}

/// @nodoc
class _$_EmailMessageChanged implements _EmailMessageChanged {
  const _$_EmailMessageChanged(this.emailMessage)
      : assert(emailMessage != null);

  @override
  final String emailMessage;

  @override
  String toString() {
    return 'ContactUsEvent.emailMessageChanged(emailMessage: $emailMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EmailMessageChanged &&
            (identical(other.emailMessage, emailMessage) ||
                const DeepCollectionEquality()
                    .equals(other.emailMessage, emailMessage)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(emailMessage);

  @override
  _$EmailMessageChangedCopyWith<_EmailMessageChanged> get copyWith =>
      __$EmailMessageChangedCopyWithImpl<_EmailMessageChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result emailMessageChanged(String emailMessage),
    @required Result emailSent(),
  }) {
    assert(emailMessageChanged != null);
    assert(emailSent != null);
    return emailMessageChanged(emailMessage);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result emailMessageChanged(String emailMessage),
    Result emailSent(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (emailMessageChanged != null) {
      return emailMessageChanged(emailMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result emailMessageChanged(_EmailMessageChanged value),
    @required Result emailSent(_EmailSent value),
  }) {
    assert(emailMessageChanged != null);
    assert(emailSent != null);
    return emailMessageChanged(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result emailMessageChanged(_EmailMessageChanged value),
    Result emailSent(_EmailSent value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (emailMessageChanged != null) {
      return emailMessageChanged(this);
    }
    return orElse();
  }
}

abstract class _EmailMessageChanged implements ContactUsEvent {
  const factory _EmailMessageChanged(String emailMessage) =
      _$_EmailMessageChanged;

  String get emailMessage;
  _$EmailMessageChangedCopyWith<_EmailMessageChanged> get copyWith;
}

/// @nodoc
abstract class _$EmailSentCopyWith<$Res> {
  factory _$EmailSentCopyWith(
          _EmailSent value, $Res Function(_EmailSent) then) =
      __$EmailSentCopyWithImpl<$Res>;
}

/// @nodoc
class __$EmailSentCopyWithImpl<$Res> extends _$ContactUsEventCopyWithImpl<$Res>
    implements _$EmailSentCopyWith<$Res> {
  __$EmailSentCopyWithImpl(_EmailSent _value, $Res Function(_EmailSent) _then)
      : super(_value, (v) => _then(v as _EmailSent));

  @override
  _EmailSent get _value => super._value as _EmailSent;
}

/// @nodoc
class _$_EmailSent implements _EmailSent {
  const _$_EmailSent();

  @override
  String toString() {
    return 'ContactUsEvent.emailSent()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _EmailSent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result emailMessageChanged(String emailMessage),
    @required Result emailSent(),
  }) {
    assert(emailMessageChanged != null);
    assert(emailSent != null);
    return emailSent();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result emailMessageChanged(String emailMessage),
    Result emailSent(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (emailSent != null) {
      return emailSent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result emailMessageChanged(_EmailMessageChanged value),
    @required Result emailSent(_EmailSent value),
  }) {
    assert(emailMessageChanged != null);
    assert(emailSent != null);
    return emailSent(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result emailMessageChanged(_EmailMessageChanged value),
    Result emailSent(_EmailSent value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (emailSent != null) {
      return emailSent(this);
    }
    return orElse();
  }
}

abstract class _EmailSent implements ContactUsEvent {
  const factory _EmailSent() = _$_EmailSent;
}

/// @nodoc
class _$ContactUsStateTearOff {
  const _$ContactUsStateTearOff();

// ignore: unused_element
  _ContactUsState call(
      {@required
          EmailMessage message,
      @required
          bool isSending,
      @required
          bool showErrorMessages,
      @required
          Option<Either<ContactUsFailure, Unit>>
              contactUsFailureOrUnitOption}) {
    return _ContactUsState(
      message: message,
      isSending: isSending,
      showErrorMessages: showErrorMessages,
      contactUsFailureOrUnitOption: contactUsFailureOrUnitOption,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ContactUsState = _$ContactUsStateTearOff();

/// @nodoc
mixin _$ContactUsState {
  EmailMessage get message;
  bool get isSending;
  bool get showErrorMessages;
  Option<Either<ContactUsFailure, Unit>> get contactUsFailureOrUnitOption;

  $ContactUsStateCopyWith<ContactUsState> get copyWith;
}

/// @nodoc
abstract class $ContactUsStateCopyWith<$Res> {
  factory $ContactUsStateCopyWith(
          ContactUsState value, $Res Function(ContactUsState) then) =
      _$ContactUsStateCopyWithImpl<$Res>;
  $Res call(
      {EmailMessage message,
      bool isSending,
      bool showErrorMessages,
      Option<Either<ContactUsFailure, Unit>> contactUsFailureOrUnitOption});
}

/// @nodoc
class _$ContactUsStateCopyWithImpl<$Res>
    implements $ContactUsStateCopyWith<$Res> {
  _$ContactUsStateCopyWithImpl(this._value, this._then);

  final ContactUsState _value;
  // ignore: unused_field
  final $Res Function(ContactUsState) _then;

  @override
  $Res call({
    Object message = freezed,
    Object isSending = freezed,
    Object showErrorMessages = freezed,
    Object contactUsFailureOrUnitOption = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed ? _value.message : message as EmailMessage,
      isSending: isSending == freezed ? _value.isSending : isSending as bool,
      showErrorMessages: showErrorMessages == freezed
          ? _value.showErrorMessages
          : showErrorMessages as bool,
      contactUsFailureOrUnitOption: contactUsFailureOrUnitOption == freezed
          ? _value.contactUsFailureOrUnitOption
          : contactUsFailureOrUnitOption
              as Option<Either<ContactUsFailure, Unit>>,
    ));
  }
}

/// @nodoc
abstract class _$ContactUsStateCopyWith<$Res>
    implements $ContactUsStateCopyWith<$Res> {
  factory _$ContactUsStateCopyWith(
          _ContactUsState value, $Res Function(_ContactUsState) then) =
      __$ContactUsStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {EmailMessage message,
      bool isSending,
      bool showErrorMessages,
      Option<Either<ContactUsFailure, Unit>> contactUsFailureOrUnitOption});
}

/// @nodoc
class __$ContactUsStateCopyWithImpl<$Res>
    extends _$ContactUsStateCopyWithImpl<$Res>
    implements _$ContactUsStateCopyWith<$Res> {
  __$ContactUsStateCopyWithImpl(
      _ContactUsState _value, $Res Function(_ContactUsState) _then)
      : super(_value, (v) => _then(v as _ContactUsState));

  @override
  _ContactUsState get _value => super._value as _ContactUsState;

  @override
  $Res call({
    Object message = freezed,
    Object isSending = freezed,
    Object showErrorMessages = freezed,
    Object contactUsFailureOrUnitOption = freezed,
  }) {
    return _then(_ContactUsState(
      message: message == freezed ? _value.message : message as EmailMessage,
      isSending: isSending == freezed ? _value.isSending : isSending as bool,
      showErrorMessages: showErrorMessages == freezed
          ? _value.showErrorMessages
          : showErrorMessages as bool,
      contactUsFailureOrUnitOption: contactUsFailureOrUnitOption == freezed
          ? _value.contactUsFailureOrUnitOption
          : contactUsFailureOrUnitOption
              as Option<Either<ContactUsFailure, Unit>>,
    ));
  }
}

/// @nodoc
class _$_ContactUsState implements _ContactUsState {
  const _$_ContactUsState(
      {@required this.message,
      @required this.isSending,
      @required this.showErrorMessages,
      @required this.contactUsFailureOrUnitOption})
      : assert(message != null),
        assert(isSending != null),
        assert(showErrorMessages != null),
        assert(contactUsFailureOrUnitOption != null);

  @override
  final EmailMessage message;
  @override
  final bool isSending;
  @override
  final bool showErrorMessages;
  @override
  final Option<Either<ContactUsFailure, Unit>> contactUsFailureOrUnitOption;

  @override
  String toString() {
    return 'ContactUsState(message: $message, isSending: $isSending, showErrorMessages: $showErrorMessages, contactUsFailureOrUnitOption: $contactUsFailureOrUnitOption)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ContactUsState &&
            (identical(other.message, message) ||
                const DeepCollectionEquality()
                    .equals(other.message, message)) &&
            (identical(other.isSending, isSending) ||
                const DeepCollectionEquality()
                    .equals(other.isSending, isSending)) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                const DeepCollectionEquality()
                    .equals(other.showErrorMessages, showErrorMessages)) &&
            (identical(other.contactUsFailureOrUnitOption,
                    contactUsFailureOrUnitOption) ||
                const DeepCollectionEquality().equals(
                    other.contactUsFailureOrUnitOption,
                    contactUsFailureOrUnitOption)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(isSending) ^
      const DeepCollectionEquality().hash(showErrorMessages) ^
      const DeepCollectionEquality().hash(contactUsFailureOrUnitOption);

  @override
  _$ContactUsStateCopyWith<_ContactUsState> get copyWith =>
      __$ContactUsStateCopyWithImpl<_ContactUsState>(this, _$identity);
}

abstract class _ContactUsState implements ContactUsState {
  const factory _ContactUsState(
      {@required
          EmailMessage message,
      @required
          bool isSending,
      @required
          bool showErrorMessages,
      @required
          Option<Either<ContactUsFailure, Unit>>
              contactUsFailureOrUnitOption}) = _$_ContactUsState;

  @override
  EmailMessage get message;
  @override
  bool get isSending;
  @override
  bool get showErrorMessages;
  @override
  Option<Either<ContactUsFailure, Unit>> get contactUsFailureOrUnitOption;
  @override
  _$ContactUsStateCopyWith<_ContactUsState> get copyWith;
}
