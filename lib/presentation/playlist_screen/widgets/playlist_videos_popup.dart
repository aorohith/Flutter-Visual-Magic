import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_magic/db/Models/models.dart';
import 'package:visual_magic/main.dart';

import '../../../application/videos/videos_bloc.dart';

// ignore: must_be_immutable
class PlayVideosPopup extends StatefulWidget {
  String videoPath;
  String playlistName;
  PlayVideosPopup(
      {Key? key, required this.videoPath, required this.playlistName})
      : super(key: key);

  @override
  State<PlayVideosPopup> createState() => _PlayVideosPopupState();
}

class _PlayVideosPopupState extends State<PlayVideosPopup> {
  bool isInPlaylist = false;

  @override
  Widget build(BuildContext context) {
    _checkPlaylistVideos();
    return PopupMenuButton(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                  onTap: () {
                    final playlistVideo = PlayListVideos(
                        playListName: widget.playlistName,
                        playListVideo: widget.videoPath);
                    if (isInPlaylist) {
                      playListVideosDB.add(playlistVideo);
                      isInPlaylist = !isInPlaylist;
                      context
                          .read<FavPopupBloc>()
                          .add(ChangeFavPopupEvent(status: isInPlaylist));
                    } else {
                      _deletePlaylistVideo(playlistVideo);
                      isInPlaylist = !isInPlaylist;
                      context
                          .read<FavPopupBloc>()
                          .add(ChangeFavPopupEvent(status: isInPlaylist));
                    }
                  },
                  value: 'Lion',
                  child: BlocBuilder<FavPopupBloc, FavPopupState>(
                    builder: (context, state) {
                      return isInPlaylist
                          ? const Text('Add to Watch Later')
                          : const Text('Remove from Watch Later');
                    },
                  )),
            ],
        onSelected: (selected) {});
  }

  _checkPlaylistVideos() {
    if (playListVideosDB.values.isNotEmpty) {
      final playlistVideos = playListVideosDB.values.toList();
      final isFound = playlistVideos.where((element) =>
          element.playListVideo == widget.videoPath &&
          element.playListName == widget.playlistName);
      if (isFound.isEmpty) {
        isInPlaylist = true; //video not exist playlist
      } else {
        isInPlaylist = false; //video exists in playlist
      }
    } else {
      isInPlaylist = true;
    }
  }

  _deletePlaylistVideo(PlayListVideos playListVideo) {
    final Map<dynamic, PlayListVideos> playlistVideosMap =
        playListVideosDB.toMap();
    dynamic desiredKey;
    playlistVideosMap.forEach((key, value) {
      if (value.playListName == playListVideo.playListName &&
          value.playListVideo == playListVideo.playListVideo) desiredKey = key;
    });
    playListVideosDB.delete(desiredKey);
  }
}
