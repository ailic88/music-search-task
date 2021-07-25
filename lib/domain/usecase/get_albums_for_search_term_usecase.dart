import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:music_search_task/core/error/failures.dart';
import 'package:music_search_task/core/usecase.dart';
import 'package:music_search_task/data/model/album.dart';
import 'package:music_search_task/domain/repository/album_repository.dart';

class GetAlbumForSearchTermUseCase implements UseCase<void, GetAlbumForSearchTermUseCaseParams> {
  final AlbumRepository _albumRepository;

  GetAlbumForSearchTermUseCase(this._albumRepository);

  @override
  Future<Either<Failure, List<Album>>> call(GetAlbumForSearchTermUseCaseParams params) async {
    return _albumRepository.searchForAlbums(params.searchTerm);
  }
}

class GetAlbumForSearchTermUseCaseParams extends Equatable {
  final String searchTerm;

  GetAlbumForSearchTermUseCaseParams(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}
