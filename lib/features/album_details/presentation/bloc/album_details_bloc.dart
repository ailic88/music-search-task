import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:music_search_task/core/injection_container.dart';
import 'package:music_search_task/data/model/album_details.dart';
import 'package:music_search_task/domain/usecase/get_album_details_usecase.dart';

part 'album_details_event.dart';

part 'album_details_state.dart';

class AlbumDetailsBloc extends Bloc<AlbumDetailsEvent, AlbumDetailsState> {
  AlbumDetailsBloc() : super(AlbumDetailsInitial());

  @override
  Stream<AlbumDetailsState> mapEventToState(
    AlbumDetailsEvent event,
  ) async* {
    if (event is GetAlbumDetailsEvent) {
      final result = await GetAlbumDetailsUseCase(getIt())(
        GetAlbumDetailsUseCaseParams(artistName: event.artistName, albumName: event.albumName),
      );

      yield* result.fold(
        (failure)async* {
          yield AlbumsErrorState(failure.message);
        },
        (albumDetails) async* {
          yield AlbumDetailsLoadedState(albumDetails);
        },
      );
    }
  }
}
