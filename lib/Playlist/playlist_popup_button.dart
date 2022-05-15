//playlist popup

import 'package:flutter/material.dart';
import 'package:visual_magic/Playlist/playlist_refactor.dart';
import 'package:visual_magic/db/Models/PlayList/playlist_model.dart';
import 'package:visual_magic/main.dart';

//Rename and delete playlist popup button
class PlaylistScreenPopup extends StatefulWidget {
  int playIndex;
  String playName;
  PlaylistScreenPopup({Key? key, required this.playIndex, required this.playName})
      : super(key: key);

  @override
  State<PlaylistScreenPopup> createState() => _PlaylistScreenPopupState();
}

class _PlaylistScreenPopupState extends State<PlaylistScreenPopup> {
  var isWatchlater;

  @override
  Widget build(BuildContext context) {
    // _checkWatchlater();
    return PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                  onTap: () {
                    playlistEdit(
                      context: context,
                      playName: widget.playName,
                      index: widget.playIndex,
                    );
                  },
                  child: Text('Rename Playlist'),
                  value: 'Doge'),
              PopupMenuItem<String>(
                  onTap: () {
                    playListNameDB.deleteAt(widget.playIndex);
                  },
                  child: Text('Delete Playlist'),
                  value: 'Lion'),
            ],
        onSelected: (_selected) {
          print(_selected);
        });
  }

  _deleteWatchlater(PlayListName _playlistName) {
    final Map<dynamic, PlayListName> watchlaterMap = playListNameDB.toMap();
    dynamic desiredKey;
    watchlaterMap.forEach((key, value) {
      if (value.playListName == _playlistName.playListName) desiredKey = key;
    });
    watchlaterDB.delete(desiredKey);
  }
}

//playlist edit popup screen

playlistEdit(
    {required BuildContext context,
    required String playName,
    required int index}) {
  final GlobalKey<FormState> _formKey =
      GlobalKey(); //currentstate.validate not work without <FormState>
  TextEditingController _textController = TextEditingController(text: playName);
  showDialog(
      context: context,
      builder: (context) => Form(
            key: _formKey,
            child: AlertDialog(
              title: Text("Edit Playlist"),
              content: TextFormField(
                controller: _textController,
                decoration: InputDecoration(labelText: "Playlist Name"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Playlist Name";
                  } else if (checkPlaylistExists(value).isNotEmpty) {
                    return "Playlist already exists";
                  }
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addNewPlaylist(_textController.text.trim(), context);
                      final snackBar =
                          SnackBar(content: Text("Playlist Name Updated"));
                    }
                  },
                  child: Text(
                    "Update",
                  ),
                ),
              ],
            ),
          ));
}

editPlayDB({
  required String oldValue,
  required String newValue,
}) {
  final Map<dynamic, PlayListName> playlistNameMap = playListNameDB.toMap();
  dynamic desiredKey;
  playlistNameMap.forEach((key, value) {
    if (value.playListName == oldValue) desiredKey = key;
  });
  final playlistObj = PlayListName(playListName: newValue);
  playListNameDB.put(desiredKey, playlistObj); //playlist name changed successfully


  PlayListVideos playVideos;
  final Map<dynamic, PlayListVideos> playlistVideoMap =
      playListVideosDB.toMap();
  playlistVideoMap.forEach((key, value) {
    if (value.playListName == oldValue) {
      PlayListVideos playVideos = PlayListVideos(playListName: newValue, playListVideo: value.playListVideo);
      playListVideosDB.put(key, playVideos);
    }
  });
}


