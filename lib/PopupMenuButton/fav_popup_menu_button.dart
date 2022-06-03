import 'package:flutter/material.dart';
import 'package:visual_magic/main.dart';

import '../db/Models/models.dart';

class FavoritesPopupOption extends StatefulWidget {
  String videoPath;
  int favIndex;
  FavoritesPopupOption({Key? key, required this.videoPath, required this.favIndex})
      : super(key: key);

  @override
  State<FavoritesPopupOption> createState() => _FavoritesPopupOptionState();
}

class _FavoritesPopupOptionState extends State<FavoritesPopupOption> {
  var isWatchlater;

  @override
  Widget build(BuildContext context) {
     _checkWatchlater();
    return PopupMenuButton(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                  onTap: () {
                    favDB.deleteAt(widget.favIndex);
                  },
                  child: const Text('Remove from favourites'),
                  value: 'Doge'),

              PopupMenuItem<String>(
                  onTap: () {
                    final watchlater =
                        WatchlaterModel(laterPath: widget.videoPath);
                    if (isWatchlater) {
                      watchlaterDB.add(watchlater);
                      isWatchlater = !isWatchlater;
                    } else {
                      _deleteWatchlater(watchlater);
                      isWatchlater = !isWatchlater;
                    }
                  },
                  child: isWatchlater
                      ? const Text('Add to Watch Later')
                      : const Text('Remove from Watch Later'),
                  value: 'Lion'),
            ],
        onSelected: (_selected) {
        });
  }

  _checkWatchlater() {
    if(watchlaterDB.values.isNotEmpty){
      final watchlater = watchlaterDB.values.toList();
    final isFound =
        watchlater.where((element) => element.laterPath == widget.videoPath);
    setState(() {
      if (isFound.isEmpty) {
        isWatchlater = true; //video not exist watchlater
      } else {
        isWatchlater = false; //video exists in watchlater
      }
    });
    }else{
      isWatchlater = true;
    }
  }

  _deleteWatchlater(WatchlaterModel _watchlater) {
    final Map<dynamic, WatchlaterModel> watchlaterMap = watchlaterDB.toMap();
    dynamic desiredKey;
    watchlaterMap.forEach((key, value) {
      if (value.laterPath == _watchlater.laterPath) desiredKey = key;
    });
    watchlaterDB.delete(desiredKey);
  }
}
