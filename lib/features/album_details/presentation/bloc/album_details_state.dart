part of 'album_details_bloc.dart';

@immutable
abstract class AlbumDetailsState extends Equatable {}

class AlbumDetailsInitial extends AlbumDetailsState {
  @override
  List<Object?> get props => [];
}

class AlbumsErrorState extends AlbumDetailsState {
  final String message;

  AlbumsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class AlbumDetailsLoadedState extends AlbumDetailsState {
  final AlbumDetails albumDetails;

  AlbumDetailsLoadedState(this.albumDetails);

  @override
  List<Object> get props => [albumDetails];
}
