import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:music_search_task/data/model/image.dart';
import 'package:collection/collection.dart';
part 'album.g.dart';

@JsonSerializable(explicitToJson: true)
class Album extends Equatable {
  final String name;
  @JsonKey(name: 'artist')
  final String artistName;
  @JsonKey(name: 'image')
  final List<Image> images;

//assume that all albums have medium images
  String get coverImage => images.firstWhereOrNull((image) => image.size == 'medium')?.url ?? "";

  Album({required this.name, required this.artistName, required this.images});

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  @override
  List<Object> get props => [name, artistName];
}
