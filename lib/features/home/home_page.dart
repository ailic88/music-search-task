import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_search_task/core/design_tokens/text_style_design_token.dart';
import 'package:music_search_task/core/ui/comunicates.dart';
import 'package:music_search_task/data/model/album.dart';
import 'package:music_search_task/features/album_details/album_details_page.dart';
import 'package:music_search_task/features/home/presentation/bloc/albums_bloc.dart';
import 'package:music_search_task/res/strings.dart' as strings;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AlbumsBloc _albumBloc;

  @override
  void initState() {
    super.initState();
    _albumBloc = AlbumsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AlbumsBloc, AlbumsState>(
          bloc: _albumBloc,
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _SearchBar(albumBloc: _albumBloc),
                if (state is AlbumsInitial) ...{
                  CommunicationWidget(
                    strings.welcomeMessage,
                    textStyle: TextStyleDesignToken.titleMd(),
                  )
                },
                if (state is AlbumsErrorState) ...{CommunicationWidget(state.message)},
                if (state is AlbumsLoadedState) ...{_AlbumListWidget(state)},
                if (state is AlbumsLoadingState) ...{
                  Expanded(child: Center(child: CircularProgressIndicator()))
                }
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _albumBloc.close();
    super.dispose();
  }
}

class _AlbumListWidget extends StatelessWidget {
  final AlbumsLoadedState state;

  const _AlbumListWidget(this.state);

  @override
  Widget build(BuildContext context) {
    return state.albums.isNotEmpty
        ? Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: state.albums.length,
                itemBuilder: (BuildContext context, int index) {
                  return _AlbumListItem(state.albums[index]);
                }))
        : CommunicationWidget(strings.noAlbumFounded);
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    Key? key,
    required AlbumsBloc albumBloc,
  })  : _albumBloc = albumBloc,
        super(key: key);

  final AlbumsBloc _albumBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Icon(Icons.search),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              autofocus: true,
              onChanged: (text) => _albumBloc.add(GetAlbumsEvent(text)),
              style: TextStyleDesignToken.bodyLg(),
              decoration: InputDecoration(hintText: strings.searchBarHint),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlbumListItem extends StatelessWidget {
  final Album album;

  const _AlbumListItem(this.album);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AlbumDetailsPage(
            albumName: album.name,
            artistName: album.artistName,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: album.coverImage,
              placeholder: (context, url) => Icon(Icons.image),
              errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined),
              fit: BoxFit.cover,
              width: 58,
              height: 58,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(album.name, style: TextStyleDesignToken.titleSm())),
          ],
        ),
      ),
    );
  }
}
