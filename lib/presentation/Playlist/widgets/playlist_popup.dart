//rename playlist delete playlist
import 'package:flutter/material.dart';

import '../../../db/Models/models.dart';
import '../../../main.dart';
import 'edit_playlist.dart';

class PlaylistPopup extends StatefulWidget {
  int playIndex;
  String playName;
  PlaylistPopup({Key? key, required this.playIndex, required this.playName})
      : super(key: key);

  @override
  State<PlaylistPopup> createState() => _PlaylistPopupState();
}

class _PlaylistPopupState extends State<PlaylistPopup> {
  var isWatchlater;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                  onTap: () {
                    //edit playlist popup call
                  },
                  child: const Text('Rename Playlist'),
                  value: 'Doge'),
              PopupMenuItem<String>(
                  onTap: () {},
                  child: const Text('Delete Playlist'),
                  value: 'Lion'),
            ],
        onSelected: (_selected) {
          if (_selected == 'Lion') {
            _deletePlaylist(
                playlistVideoName: widget.playName, index: widget.playIndex);
          } else if (_selected == 'Doge') {
            playlistEdit(context: context, playName: widget.playName);
          }
        });
  }

  _deletePlaylist({required String playlistVideoName, required int index}) {
    playListNameDB.deleteAt(index); //playlist name delete from db

    final Map<dynamic, PlayListVideos> watchlaterMap = playListVideosDB.toMap();
    dynamic desiredKey;
    watchlaterMap.forEach((key, value) {
      if (value.playListName == playlistVideoName) desiredKey = key;
      watchlaterDB.delete(desiredKey); //playlist song objects delete from db
    });
  }
}