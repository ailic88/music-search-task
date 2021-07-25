import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_search_task/core/injection_container.dart';
import 'package:music_search_task/data/model/album.dart';
import 'package:music_search_task/domain/usecase/get_albums_for_search_term_usecase.dart';
import 'package:rxdart/rxdart.dart';

part 'albums_event.dart';

part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  AlbumsBloc() : super(AlbumsInitial());

  @override
  Stream<AlbumsState> mapEventToState(
    AlbumsEvent event,
  ) async* {
    if (event is GetAlbumsEvent) {
      if (event.searchTerm.isEmpty) {
        yield AlbumsInitial();
        return;
      }
      yield AlbumsLoadingState();

      final result = await getIt<GetAlbumForSearchTermUseCase>()(
          GetAlbumForSearchTermUseCaseParams(event.searchTerm));

      yield* result.fold(
        (failure) async* {
          yield AlbumsErrorState(failure.message);
        },
        (albums) async* {
          yield AlbumsLoadedState(albums);
        },
      );
    }
  }

  @override
  Stream<Transition<AlbumsEvent, AlbumsState>> transformEvents(
      Stream<AlbumsEvent> events, transitionFn) {
    //debounce calling search API events
    return events.debounceTime(const Duration(milliseconds: 300)).switchMap((transitionFn));
  }
}
