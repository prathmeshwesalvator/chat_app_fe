import 'package:chat_app_fe/app/core/networking/entities/api_response_entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true, constructor: '_')
class ApiResponseModel<T> {
  const ApiResponseModel._({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  @JsonKey(defaultValue: 0)
  final int statusCode;

  @JsonKey(defaultValue: '')
  final String message;

  @JsonKey()
  final T data;

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? object) fromJsonT,
  ) => _$ApiResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(Object? object) toJsonT) =>
      _$ApiResponseModelToJson(this, toJsonT);

  ApiResponseEntities toDomain() =>
      ApiResponseEntities(statusCode: statusCode, message: message, data: data);
}
