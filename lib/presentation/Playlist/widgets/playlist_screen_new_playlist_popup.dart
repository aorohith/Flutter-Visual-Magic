import 'package:flutter/material.dart';
import '../../../infrastructure/functions/playlist_section.dart';

playlistScreenPopup(context) {
  //popup items
  final GlobalKey<FormState> _formKey =
      GlobalKey(); //currentstate.validate not work without <FormState>
  TextEditingController _textController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => Form(
      key: _formKey,
      child: AlertDialog(
        title: const Text("Addtt Playlist"),
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
    ),
  );
}