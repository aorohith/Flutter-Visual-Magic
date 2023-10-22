import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_magic/db/Models/models.dart';
import 'package:visual_magic/main.dart';

import '../../../application/videos/videos_bloc.dart';

// ignore: must_be_immutable
class FavoritesPopupOption extends StatefulWidget {
  String videoPath;
  int favIndex;
  FavoritesPopupOption(
      {Key? key, required this.videoPath, required this.favIndex})
      : super(key: key);

  @override
  State<FavoritesPopupOption> createState() => _FavoritesPopupOptionState();
}

class _FavoritesPopupOptionState extends State<FavoritesPopupOption> {
  bool isWatchlater = false;

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
                  value: 'Doge',
                  child: const Text('Remove from favorites')),
              PopupMenuItem<String>(
                  onTap: () {
                    final watchlater =
                        WatchlaterModel(laterPath: widget.videoPath);
                    if (isWatchlater) {
                      watchlaterDB.add(watchlater);
                      isWatchlater = !isWatchlater;
                      context
                          .read<FavPopupBloc>()
                          .add(ChangeFavPopupEvent(status: isWatchlater));
                    } else {
                      _deleteWatchlater(watchlater);
                      isWatchlater = !isWatchlater;
                      context
                          .read<FavPopupBloc>()
                          .add(ChangeFavPopupEvent(status: isWatchlater));
                    }
                  },
                  value: 'Lion',
                  child: BlocBuilder<FavPopupBloc, FavPopupState>(
                    builder: (context, state) {
                      return state.favStatus
                          ? const Text('Add to Watch Later')
                          : const Text('Remove from Watch Later');
                    },
                  )),
            ],
        onSelected: (selected) {});
  }

  _checkWatchlater() {
    if (watchlaterDB.values.isNotEmpty) {
      final watchlater = watchlaterDB.values.toList();
      final isFound =
          watchlater.where((element) => element.laterPath == widget.videoPath);
      if (isFound.isEmpty) {
        isWatchlater = true; //video not exist watchlater
      } else {
        isWatchlater = false; //video exists in watchlater
      }
    } else {
      isWatchlater = true;
    }
  }

  _deleteWatchlater(WatchlaterModel watchlater) {
    final Map<dynamic, WatchlaterModel> watchlaterMap = watchlaterDB.toMap();
    dynamic desiredKey;
    watchlaterMap.forEach((key, value) {
      if (value.laterPath == watchlater.laterPath) desiredKey = key;
    });
    watchlaterDB.delete(desiredKey);
  }
}
