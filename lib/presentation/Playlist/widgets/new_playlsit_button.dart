import 'package:flutter/material.dart';
import 'playlist_screen_new_playlist_popup.dart';

Widget playlistAddButton(context) {
  //playlist screen popup of info button
  return FloatingActionButton(
    onPressed: () {
      playlistScreenPopup(context);
    },
    child: const Icon(Icons.add, size: 30, color: Colors.white),
  );
}
