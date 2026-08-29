// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_get_health200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HealthGetHealth200Response extends HealthGetHealth200Response {
  @override
  final String? status;
  @override
  final String? version;

  factory _$HealthGetHealth200Response(
          [void Function(HealthGetHealth200ResponseBuilder)? updates]) =>
      (HealthGetHealth200ResponseBuilder()..update(updates))._build();

  _$HealthGetHealth200Response._({this.status, this.version}) : super._();
  @override
  HealthGetHealth200Response rebuild(
          void Function(HealthGetHealth200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HealthGetHealth200ResponseBuilder toBuilder() =>
      HealthGetHealth200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HealthGetHealth200Response &&
        status == other.status &&
        version == other.version;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HealthGetHealth200Response')
          ..add('status', status)
          ..add('version', version))
        .toString();
  }
}

class HealthGetHealth200ResponseBuilder
    implements
        Builder<HealthGetHealth200Response, HealthGetHealth200ResponseBuilder> {
  _$HealthGetHealth200Response? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  HealthGetHealth200ResponseBuilder() {
    HealthGetHealth200Response._defaults(this);
  }

  HealthGetHealth200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _version = $v.version;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HealthGetHealth200Response other) {
    _$v = other as _$HealthGetHealth200Response;
  }

  @override
  void update(void Function(HealthGetHealth200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HealthGetHealth200Response build() => _build();

  _$HealthGetHealth200Response _build() {
    final _$result = _$v ??
        _$HealthGetHealth200Response._(
          status: status,
          version: version,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
