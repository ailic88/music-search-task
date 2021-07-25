
import 'package:music_search_task/data/model/album.dart';
import 'package:music_search_task/data/model/album_details.dart';

abstract class AlbumRemoteDataSource {
  Future<List<Album>> searchForAlbums(String searchTerm);
  Future<AlbumDetails> getAlbumDetails({required String albumName,required String artistName});
}
