import 'package:dio/dio.dart';
import 'package:music_search_task/core/error/exceptions.dart';
import 'package:music_search_task/data/model/album.dart';
import 'package:music_search_task/data/model/album_details.dart';

import 'album_remote_data_source.dart';

class AlbumRemoteDataSourceImpl extends AlbumRemoteDataSource {
  final Dio _dio;

  AlbumRemoteDataSourceImpl(this._dio);

  @override
  Future<List<Album>> searchForAlbums(String searchTerm) async {
    try {
      Response response = await _dio.get("", queryParameters: {
        "method": "album.search",
        "album": "$searchTerm",
      });
      final List albumsJson = response.data["results"]["albummatches"]["album"];
      return albumsJson.map((albumJson) => Album.fromJson(albumJson)).toList();
    } on DioError catch (error) {
      throw ServerException("$error");
    }
  }

  @override
  Future<AlbumDetails> getAlbumDetails(
      {required String albumName, required String artistName}) async {
    try {
      Response response = await _dio.get("", queryParameters: {
        "method": "album.getinfo",
        "album": "$albumName",
        "artist": "$artistName"
      });
      return AlbumDetails.fromJson(response.data['album']);
    } on DioError catch (error) {
      throw ServerException("$error");
    }
  }
}
