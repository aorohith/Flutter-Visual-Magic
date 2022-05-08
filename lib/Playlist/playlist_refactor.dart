import 'package:flutter/material.dart';
import 'package:visual_magic/db/Models/PlayList/playlist_model.dart';
import 'package:visual_magic/main.dart';

Widget playlistAdd(context) {
  return FloatingActionButton(
    onPressed: () {},
    child: IconButton(
      onPressed: () {
        playlistPopup(context);
      },
      icon: const Icon(Icons.add, size: 30, color: Colors.white),
    ),
  );
}

playlistPopup(context) {
  final GlobalKey<FormState> _formKey =
      GlobalKey(); //currentstate.validate not work without <FormState>
  TextEditingController _textController = TextEditingController();
  showDialog(
      context: context,
      builder: (context) => Form(
            key: _formKey,
            child: AlertDialog(
              title: Text("Add Playlist"),
              content: TextFormField(
                controller: _textController,
                decoration: InputDecoration(labelText: "Playlist"),
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
                          SnackBar(content: Text("Playlist Added"));
                    }
                  },
                  child: Text(
                    "Add",
                  ),
                ),
              ],
            ),
          ));
}

//check playlist exists or not
checkPlaylistExists(value) {
  List<PlayListName> currentList = playListNameDB.values.toList();
  var contains = currentList.where((element) => element.playListName == value);
  //no duplicaate items in the list of objects
  return contains;
}

//Add new palylist to the list of playlists
addNewPlaylist(String value, BuildContext context) {
  final playlist = PlayListName(playListName: value);
  playListNameDB.add(playlist);
  Navigator.pop(context);
}

//add new play list videos to ########
