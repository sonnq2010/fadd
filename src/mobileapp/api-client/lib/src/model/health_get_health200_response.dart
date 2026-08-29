//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'health_get_health200_response.g.dart';

/// HealthGetHealth200Response
///
/// Properties:
/// * [status]
/// * [version]
@BuiltValue()
abstract class HealthGetHealth200Response
    implements
        Built<HealthGetHealth200Response, HealthGetHealth200ResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'version')
  String? get version;

  HealthGetHealth200Response._();

  factory HealthGetHealth200Response(
          [void updates(HealthGetHealth200ResponseBuilder b)]) =
      _$HealthGetHealth200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HealthGetHealth200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HealthGetHealth200Response> get serializer =>
      _$HealthGetHealth200ResponseSerializer();
}

class _$HealthGetHealth200ResponseSerializer
    implements PrimitiveSerializer<HealthGetHealth200Response> {
  @override
  final Iterable<Type> types = const [
    HealthGetHealth200Response,
    _$HealthGetHealth200Response
  ];

  @override
  final String wireName = r'HealthGetHealth200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HealthGetHealth200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.version != null) {
      yield r'version';
      yield serializers.serialize(
        object.version,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HealthGetHealth200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HealthGetHealth200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.version = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HealthGetHealth200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HealthGetHealth200ResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
