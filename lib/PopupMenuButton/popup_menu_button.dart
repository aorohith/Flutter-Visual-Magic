import 'package:flutter/material.dart';
import 'package:visual_magic/db/Models/Watchlater/watch_later_model.dart';
import 'package:visual_magic/main.dart';

class PopupOption extends StatefulWidget {
  String videoPath;
  int favIndex;
  PopupOption({Key? key, required this.videoPath, required this.favIndex})
      : super(key: key);

  @override
  State<PopupOption> createState() => _PopupOptionState();
}

class _PopupOptionState extends State<PopupOption> {
  var isWatchlater;

  @override
  Widget build(BuildContext context) {
     _checkWatchlater();
    return PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (_) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                  onTap: () {
                    favDB.deleteAt(widget.favIndex);
                  },
                  child: Text('Remove from favourites'),
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
                      ? Text('Add to Watch Later')
                      : Text('Remove from Watch Later'),
                  value: 'Lion'),
            ],
        onSelected: (_selected) {
          print(_selected);
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
