import 'package:dartz/dartz.dart';
import 'package:music_search_task/core/error/failures.dart';
import 'package:music_search_task/data/datasrouces/album_remote_data_source.dart';
import 'package:music_search_task/data/model/album.dart';
import 'package:music_search_task/data/model/album_details.dart';
import 'package:music_search_task/domain/repository/album_repository.dart';
import 'package:music_search_task/res/strings_error.dart';

class AlbumRepositoryImpl extends AlbumRepository {
  final AlbumRemoteDataSource _albumRemoteDataSource;

  AlbumRepositoryImpl(this._albumRemoteDataSource);

  @override
  Future<Either<Failure, List<Album>>> searchForAlbums(String searchTerm) async {
    try {
      final result = await _albumRemoteDataSource.searchForAlbums(searchTerm);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(UNKNOWN));
    }
  }

  @override
  Future<Either<Failure, AlbumDetails>> getAlbumDetails({
    required String albumName,
    required String artistName,
  }) async {
    try {
      final result = await _albumRemoteDataSource.getAlbumDetails(
        albumName: albumName,
        artistName: artistName,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(UNKNOWN));
    }
  }
}
