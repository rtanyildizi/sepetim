// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'item_category_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ItemCategoryDto _$ItemCategoryDtoFromJson(Map<String, dynamic> json) {
  return _ItemCategoryDto.fromJson(json);
}

class _$ItemCategoryDtoTearOff {
  const _$ItemCategoryDtoTearOff();

  _ItemCategoryDto call(
      {@JsonKey(ignore: true) String uid,
      @required String title,
      @required int color,
      @required String coverImageUrl}) {
    return _ItemCategoryDto(
      uid: uid,
      title: title,
      color: color,
      coverImageUrl: coverImageUrl,
    );
  }
}

// ignore: unused_element
const $ItemCategoryDto = _$ItemCategoryDtoTearOff();

mixin _$ItemCategoryDto {
  @JsonKey(ignore: true)
  String get uid;
  String get title;
  int get color;
  String get coverImageUrl;

  Map<String, dynamic> toJson();
  $ItemCategoryDtoCopyWith<ItemCategoryDto> get copyWith;
}

abstract class $ItemCategoryDtoCopyWith<$Res> {
  factory $ItemCategoryDtoCopyWith(
          ItemCategoryDto value, $Res Function(ItemCategoryDto) then) =
      _$ItemCategoryDtoCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(ignore: true) String uid,
      String title,
      int color,
      String coverImageUrl});
}

class _$ItemCategoryDtoCopyWithImpl<$Res>
    implements $ItemCategoryDtoCopyWith<$Res> {
  _$ItemCategoryDtoCopyWithImpl(this._value, this._then);

  final ItemCategoryDto _value;
  // ignore: unused_field
  final $Res Function(ItemCategoryDto) _then;

  @override
  $Res call({
    Object uid = freezed,
    Object title = freezed,
    Object color = freezed,
    Object coverImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed ? _value.uid : uid as String,
      title: title == freezed ? _value.title : title as String,
      color: color == freezed ? _value.color : color as int,
      coverImageUrl: coverImageUrl == freezed
          ? _value.coverImageUrl
          : coverImageUrl as String,
    ));
  }
}

abstract class _$ItemCategoryDtoCopyWith<$Res>
    implements $ItemCategoryDtoCopyWith<$Res> {
  factory _$ItemCategoryDtoCopyWith(
          _ItemCategoryDto value, $Res Function(_ItemCategoryDto) then) =
      __$ItemCategoryDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(ignore: true) String uid,
      String title,
      int color,
      String coverImageUrl});
}

class __$ItemCategoryDtoCopyWithImpl<$Res>
    extends _$ItemCategoryDtoCopyWithImpl<$Res>
    implements _$ItemCategoryDtoCopyWith<$Res> {
  __$ItemCategoryDtoCopyWithImpl(
      _ItemCategoryDto _value, $Res Function(_ItemCategoryDto) _then)
      : super(_value, (v) => _then(v as _ItemCategoryDto));

  @override
  _ItemCategoryDto get _value => super._value as _ItemCategoryDto;

  @override
  $Res call({
    Object uid = freezed,
    Object title = freezed,
    Object color = freezed,
    Object coverImageUrl = freezed,
  }) {
    return _then(_ItemCategoryDto(
      uid: uid == freezed ? _value.uid : uid as String,
      title: title == freezed ? _value.title : title as String,
      color: color == freezed ? _value.color : color as int,
      coverImageUrl: coverImageUrl == freezed
          ? _value.coverImageUrl
          : coverImageUrl as String,
    ));
  }
}

@JsonSerializable()
class _$_ItemCategoryDto extends _ItemCategoryDto {
  const _$_ItemCategoryDto(
      {@JsonKey(ignore: true) this.uid,
      @required this.title,
      @required this.color,
      @required this.coverImageUrl})
      : assert(title != null),
        assert(color != null),
        assert(coverImageUrl != null),
        super._();

  factory _$_ItemCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$_$_ItemCategoryDtoFromJson(json);

  @override
  @JsonKey(ignore: true)
  final String uid;
  @override
  final String title;
  @override
  final int color;
  @override
  final String coverImageUrl;

  @override
  String toString() {
    return 'ItemCategoryDto(uid: $uid, title: $title, color: $color, coverImageUrl: $coverImageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ItemCategoryDto &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.coverImageUrl, coverImageUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(color) ^
      const DeepCollectionEquality().hash(coverImageUrl);

  @override
  _$ItemCategoryDtoCopyWith<_ItemCategoryDto> get copyWith =>
      __$ItemCategoryDtoCopyWithImpl<_ItemCategoryDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ItemCategoryDtoToJson(this);
  }
}

abstract class _ItemCategoryDto extends ItemCategoryDto {
  const _ItemCategoryDto._() : super._();
  const factory _ItemCategoryDto(
      {@JsonKey(ignore: true) String uid,
      @required String title,
      @required int color,
      @required String coverImageUrl}) = _$_ItemCategoryDto;

  factory _ItemCategoryDto.fromJson(Map<String, dynamic> json) =
      _$_ItemCategoryDto.fromJson;

  @override
  @JsonKey(ignore: true)
  String get uid;
  @override
  String get title;
  @override
  int get color;
  @override
  String get coverImageUrl;
  @override
  _$ItemCategoryDtoCopyWith<_ItemCategoryDto> get copyWith;
}
