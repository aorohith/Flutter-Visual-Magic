import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visual_magic/Screens/Playlist/playlist_popup_button.dart';
import 'package:visual_magic/db/Models/models.dart';
import 'package:visual_magic/db/functions.dart';
import 'package:visual_magic/main.dart';

bool notifyPlaylistVideo = false;

Widget playlistAdd(context) {
  //playlist screen popup of info button
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
  //popup items
  final GlobalKey<FormState> _formKey =
      GlobalKey(); //currentstate.validate not work without <FormState>
  TextEditingController _textController = TextEditingController();
  showDialog(
      context: context,
      builder: (context) => Form(
            key: _formKey,
            child: AlertDialog(
              title: const Text("Add Playlist"),
              content: TextFormField(
                controller: _textController,
                decoration: const InputDecoration(labelText: "Playlist"),
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
                    }
                  },
                  child: const Text(
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

playlistVideoPopup({required context, required playlistVideoPath}) {
  final GlobalKey<FormState> _formKey =
      GlobalKey(); //currentstate.validate not work without <FormState>
  TextEditingController _textController = TextEditingController();
  showDialog(
      context: context,
      builder: (context) => Form(
            key: _formKey,
            child: AlertDialog(
              title: const Text("Playlists"),
              content: ValueListenableBuilder(
                valueListenable: playListNameDB.listenable(),
                builder: (BuildContext ctx, Box<PlayListName> playListName,
                    Widget? child) {
                  return SizedBox(
                    height: 300,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _textController,
                          decoration:
                              const InputDecoration(labelText: "New Playlist"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Playlist Name";
                            } else if (checkPlaylistExists(value).isNotEmpty) {
                              return "Playlist already exists";
                            }
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              addNewPlaylist(
                                  _textController.text.trim(), context);
                            }
                          },
                          child: const Text(
                            "Add New",
                          ),
                        ),
                        SizedBox(
                          height: 190.0, // Change as per your requirement
                          width: 300.0,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: playListName.length,
                            itemBuilder: (context, index) {
                              PlayListName? playName =
                                  playListName.getAt(index);
                              return ListTile(
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: 0),
                                onTap: () {
                                  notifyPlaylistVideo = !notifyPlaylistVideo;
                                  final playListVideoToAdd = PlayListVideos(
                                    playListName: playName!.playListName,
                                    playListVideo: playlistVideoPath,
                                  );
                                  final contains =
                                      addPlayListVideos(playListVideoToAdd);
                                  if (contains) {
                                    Navigator.pop(context);
                                  } else {
                                    // Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);

                                    notifyPlaylistVideo = true;
                                  }
                                },
                                title: Text(playName!.playListName),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ));
}

//rename playlist delete playlist
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

//playlist edit popup

playlistEdit(
    {required BuildContext context, required String playName, required}) {
  final GlobalKey<FormState> _formKey =
      GlobalKey(); //currentstate.validate not work without <FormState>
  TextEditingController _textController = TextEditingController(text: playName);
  showDialog(
      context: context,
      builder: (context) => Form(
            key: _formKey,
            child: AlertDialog(
              title: const Text("Edit Playlist"),
              content: TextFormField(
                controller: _textController,
                decoration: const InputDecoration(labelText: "Playlist Name"),
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
                      editPlayDB(
                        oldValue: playName,
                        newValue: _textController.text.trim(),
                      );
                      Navigator.pop(context);
                      const snackBar =
                          SnackBar(content: Text("Playlist Name Updated"));
                    }
                  },
                  child: const Text(
                    "Update",
                  ),
                ),
              ],
            ),
          ));
}
