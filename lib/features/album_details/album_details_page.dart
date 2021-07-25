import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_search_task/core/design_tokens/text_style_design_token.dart';
import 'package:music_search_task/core/ui/comunicates.dart';
import 'package:music_search_task/core/utilities.dart';
import 'package:music_search_task/data/model/album_details.dart';
import 'package:music_search_task/features/album_details/presentation/bloc/album_details_bloc.dart';

class AlbumDetailsPage extends StatefulWidget {
  final String albumName;
  final String artistName;

  const AlbumDetailsPage({Key? key, required this.albumName, required this.artistName})
      : super(key: key);

  @override
  _AlbumDetailsPageState createState() => _AlbumDetailsPageState();
}

class _AlbumDetailsPageState extends State<AlbumDetailsPage> {
  late AlbumDetailsBloc _albumDetailsBloc;

  @override
  void initState() {
    super.initState();
    _albumDetailsBloc = AlbumDetailsBloc()
      ..add(
        GetAlbumDetailsEvent(
          albumName: widget.albumName,
          artistName: widget.artistName,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder<AlbumDetailsBloc, AlbumDetailsState>(
          bloc: _albumDetailsBloc,
          builder: (context, state) {
            if (state is AlbumDetailsLoadedState) {
              return _AlbumDetailsWidget(albumDetails: state.albumDetails);
            } else if (state is AlbumsErrorState) {
              return CommunicationWidget(state.message);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _albumDetailsBloc.close();
    super.dispose();
  }
}

class _AlbumDetailsWidget extends StatelessWidget {
  final AlbumDetails albumDetails;

  const _AlbumDetailsWidget({required this.albumDetails});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: albumDetails.coverImage,
              placeholder: (context, url) => Icon(Icons.image),
              errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined),
              fit: BoxFit.contain,
              height: 250,
            ),
            const SizedBox(height: 16),
            Text(albumDetails.name, style: TextStyleDesignToken.titleLg()),
            const SizedBox(height: 8),
            Text(albumDetails.artist, style: TextStyleDesignToken.titleMd()),
            const SizedBox(height: 8),
            Row(
              children: [
                const Spacer(),
                Icon(Icons.surround_sound_outlined),
                const SizedBox(width: 4),
                Text(albumDetails.listeners),
                const Spacer(),
                Icon(Icons.audiotrack),
                const SizedBox(width: 4),
                Text(albumDetails.playcount),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 24),
            _TracksListWidget(albumDetails.tracks),
            const SizedBox(height: 24),
            Text(albumDetails.wiki?.summary ?? ""),
          ],
        ),
      ),
    );
  }
}

class _TracksListWidget extends StatelessWidget {
  final List<Track> tracks;

  const _TracksListWidget(this.tracks);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tracks.length,
        itemBuilder: (BuildContext context, int index) {
          return _TrackListItem(tracks[index]);
        });
  }
}

class _TrackListItem extends StatelessWidget {
  final Track track;

  const _TrackListItem(this.track);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Icon(Icons.play_circle_outline),
          const SizedBox(width: 8),
          Expanded(child: Text(track.name, style: TextStyleDesignToken.titleSm())),
          Text(formattedSongDuration(Duration(seconds: track.duration))),
        ],
      ),
    );
  }
}
