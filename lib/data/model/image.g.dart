// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) {
  return Image(
    url: json['#text'] as String?,
    size: json['size'] as String?,
  );
}

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      '#text': instance.url,
      'size': instance.size,
    };
