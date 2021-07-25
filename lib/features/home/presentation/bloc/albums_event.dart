part of 'albums_bloc.dart';

@immutable
abstract class AlbumsEvent {}
class GetAlbumsEvent extends AlbumsEvent{
  final String searchTerm;

  GetAlbumsEvent(this.searchTerm);
}