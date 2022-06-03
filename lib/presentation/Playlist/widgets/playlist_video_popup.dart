//add new play list videos to ########

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../db/Models/models.dart';
import '../../../db/functions.dart';
import '../../../infrastructure/functions/playlist_section.dart';
import '../../../main.dart';

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