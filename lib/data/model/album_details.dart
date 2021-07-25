import 'package:equatable/equatable.dart';
import 'package:music_search_task/data/model/image.dart';
import 'package:collection/collection.dart';

class AlbumDetails extends Equatable {
  final String listeners;
  final String playcount;
  final Wiki? wiki;
  final List<Track> tracks;
  final List<Image> images;
  final String artist;
  final String name;

  AlbumDetails({
    required this.listeners,
    required this.playcount,
    this.wiki,
    required this.tracks,
    required this.images,
    required this.artist,
    required this.name,
  });

  //custom from json method
  AlbumDetails.fromJson(Map<String, dynamic> json)
      : listeners = json['listeners'],
        playcount = json['playcount'],
        wiki = json['wiki'] != null ? new Wiki.fromJson(json['wiki']) : null,
        tracks = json['tracks'] == null
            ? <Track>[]
            : json['tracks']["track"].map<Track>((v) => Track.fromJson(v)).toList(),
        images = json['image'] != null
            ? json['image'].map<Image>((v) => Image.fromJson(v)).toList()
            : <Image>[],
        artist = json['artist'],
        name = json['name'];

  String get coverImage => images.firstWhereOrNull((image) => image.size == 'large')?.url ?? "";

  @override
  List<Object?> get props => [artist, name];
}

class Wiki {
  String? published;
  String? content;
  String? summary;

  Wiki({this.published, this.content, this.summary});

  Wiki.fromJson(Map<String, dynamic> json) {
    published = json['published'];
    content = json['content'];
    summary = json['summary'];
  }
}

class Track {
  String artistName;
  int? duration;
  String name;

  Track({required this.artistName, required this.duration, required this.name});

  Track.fromJson(Map<String, dynamic> json)
      : artistName = json['artist'] != null ? json['artist']["name"] : "",
        duration = json['duration'],
        name = json['name'];
}
