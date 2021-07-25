import 'package:music_search_task/core/config/config.dart' as config;
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:music_search_task/data/datasrouces/album_remote_data_source.dart';
import 'package:music_search_task/data/datasrouces/album_remote_data_source_impl.dart';
import 'package:music_search_task/data/repository/album_repository_impl.dart';
import 'package:music_search_task/domain/repository/album_repository.dart';
import 'package:music_search_task/domain/usecase/get_albums_for_search_term_usecase.dart';

import 'network/dio_client.dart';

final getIt = GetIt.instance;

void initDependencies() {
  //Networking
  getIt.registerLazySingleton<Dio>(() => DioClient.createDioClient().dio);

  _registerRemoteDataSources();
  _registerRepositories();
  _registerUseCases();
}

void _registerRemoteDataSources() {
  getIt.registerLazySingleton<AlbumRemoteDataSource>(() => AlbumRemoteDataSourceImpl(getIt()));
}

void _registerRepositories() {
  getIt.registerLazySingleton<AlbumRepository>(() => AlbumRepositoryImpl(getIt()));
}

void _registerUseCases() {
  getIt.registerFactory<GetAlbumForSearchTermUseCase>(() => GetAlbumForSearchTermUseCase(getIt()));
}
