part of 'album_details_bloc.dart';

@immutable
abstract class AlbumDetailsEvent {}

class GetAlbumDetailsEvent extends AlbumDetailsEvent {
  final String albumName;
  final String artistName;

  GetAlbumDetailsEvent({required this.albumName, required this.artistName});
}
