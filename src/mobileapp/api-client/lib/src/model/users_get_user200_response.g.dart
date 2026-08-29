// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_get_user200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UsersGetUser200Response extends UsersGetUser200Response {
  @override
  final String? createdAt;
  @override
  final String? displayName;
  @override
  final String? email;
  @override
  final String? id;
  @override
  final String? updatedAt;

  factory _$UsersGetUser200Response(
          [void Function(UsersGetUser200ResponseBuilder)? updates]) =>
      (UsersGetUser200ResponseBuilder()..update(updates))._build();

  _$UsersGetUser200Response._(
      {this.createdAt, this.displayName, this.email, this.id, this.updatedAt})
      : super._();
  @override
  UsersGetUser200Response rebuild(
          void Function(UsersGetUser200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UsersGetUser200ResponseBuilder toBuilder() =>
      UsersGetUser200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UsersGetUser200Response &&
        createdAt == other.createdAt &&
        displayName == other.displayName &&
        email == other.email &&
        id == other.id &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UsersGetUser200Response')
          ..add('createdAt', createdAt)
          ..add('displayName', displayName)
          ..add('email', email)
          ..add('id', id)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class UsersGetUser200ResponseBuilder
    implements
        Builder<UsersGetUser200Response, UsersGetUser200ResponseBuilder> {
  _$UsersGetUser200Response? _$v;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  UsersGetUser200ResponseBuilder() {
    UsersGetUser200Response._defaults(this);
  }

  UsersGetUser200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _createdAt = $v.createdAt;
      _displayName = $v.displayName;
      _email = $v.email;
      _id = $v.id;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UsersGetUser200Response other) {
    _$v = other as _$UsersGetUser200Response;
  }

  @override
  void update(void Function(UsersGetUser200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UsersGetUser200Response build() => _build();

  _$UsersGetUser200Response _build() {
    final _$result = _$v ??
        _$UsersGetUser200Response._(
          createdAt: createdAt,
          displayName: displayName,
          email: email,
          id: id,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
