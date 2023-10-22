//playlist edit popup

import 'package:flutter/material.dart';
import '../../../infrastructure/functions/playlist_section.dart';

playlistEdit(
    {required BuildContext context, required String playName, required}) {
  final GlobalKey<FormState> formKey =
      GlobalKey(); //current state.validate not work without <FormState>
  TextEditingController textController = TextEditingController(text: playName);
  showDialog(
    context: context,
    builder: (context) => Form(
      key: formKey,
      child: AlertDialog(
        title: const Text("Edit Playlist"),
        content: TextFormField(
          controller: textController,
          decoration: const InputDecoration(labelText: "Playlist Name"),
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
                editPlayDB(
                  oldValue: playName,
                  newValue: textController.text.trim(),
                );
                Navigator.pop(context);
              }
            },
            child: const Text(
              "Update",
            ),
          ),
        ],
      ),
    ),
  );
}
