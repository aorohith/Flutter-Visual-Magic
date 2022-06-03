//playlist edit popup

import 'package:flutter/material.dart';

import '../../../db/functions.dart';

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
    ),
  );
}