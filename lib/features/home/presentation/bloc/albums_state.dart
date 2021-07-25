part of 'albums_bloc.dart';

@immutable
abstract class AlbumsState extends Equatable {}

class AlbumsInitial extends AlbumsState {
  @override
  List<Object?> get props => [];
}

class AlbumsLoadingState extends AlbumsState {
  @override
  List<Object?> get props => [];
}

class AlbumsErrorState extends AlbumsState {
  final String message;

  AlbumsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class AlbumsLoadedState extends AlbumsState {
  final List<Album> albums;

  AlbumsLoadedState(this.albums);

  @override
  List<Object> get props => [albums];
}
