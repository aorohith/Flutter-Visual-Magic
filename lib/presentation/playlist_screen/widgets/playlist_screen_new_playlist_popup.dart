import 'package:flutter/material.dart';
import '../../../infrastructure/functions/playlist_section.dart';

playlistScreenPopup(context) {
  //popup items
  final GlobalKey<FormState> formKey =
      GlobalKey(); //currentstate.validate not work without <FormState>
  TextEditingController textController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => SizedBox(
      child: Form(
        key: formKey,
        child: AlertDialog(
          title: const Text("Add Playlist"),
          content: TextFormField(
            controller: textController,
            decoration: const InputDecoration(labelText: "Playlist"),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter Playlist Name";
              } else if (checkPlaylistExists(value).isNotEmpty) {
                return "Playlist already exists";
              }
              return null;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  addNewPlaylist(textController.text.trim(), context);
                }
              },
              child: const Text(
                "Add",
              ),
            ),
          ],
        ),
      ),
    ),
  );
}