import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:music_search_task/core/error/failures.dart';
import 'package:music_search_task/core/usecase.dart';
import 'package:music_search_task/data/model/album_details.dart';
import 'package:music_search_task/domain/repository/album_repository.dart';

class GetAlbumDetailsUseCase implements UseCase<void, GetAlbumDetailsUseCaseParams> {
  final AlbumRepository _albumRepository;

  GetAlbumDetailsUseCase(this._albumRepository);

  @override
  Future<Either<Failure, AlbumDetails>> call(GetAlbumDetailsUseCaseParams params) async {
    return _albumRepository.getAlbumDetails(
      albumName: params.albumName,
      artistName: params.artistName,
    );
  }
}

class GetAlbumDetailsUseCaseParams extends Equatable {
  final String albumName;
  final String artistName;

  GetAlbumDetailsUseCaseParams({required this.albumName, required this.artistName});

  @override
  List<Object> get props => [albumName, artistName];
}
