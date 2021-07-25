import 'package:dartz/dartz.dart';
import 'package:music_search_task/core/error/failures.dart';
import 'package:music_search_task/data/model/album.dart';
import 'package:music_search_task/data/model/album_details.dart';

abstract class AlbumRepository {
  Future<Either<Failure, List<Album>>> searchForAlbums(String searchTerm);

  Future<Either<Failure, AlbumDetails>> getAlbumDetails({
    required String albumName,
    required String artistName,
  });
}
