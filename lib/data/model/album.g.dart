// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return Album(
    name: json['name'] as String,
    artistName: json['artist'] as String,
    images: (json['image'] as List<dynamic>)
        .map((e) => Image.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'name': instance.name,
      'artist': instance.artistName,
      'image': instance.images.map((e) => e.toJson()).toList(),
    };
