import 'package:flutter/material.dart';
import 'package:visual_magic/db/Models/Favourites/favourites_model.dart';
import 'package:visual_magic/db/functions.dart';
import 'package:visual_magic/main.dart';

class PopupOption extends StatefulWidget {
  String videoPath;
  PopupOption({Key? key, required this.videoPath}) : super(key: key);

  @override
  State<PopupOption> createState() => _PopupOptionState();
}

class _PopupOptionState extends State<PopupOption> {
  List<Favourites>favData = favDB.get(''); 
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (_) => <PopupMenuItem<String>>[

              PopupMenuItem<String>(
                  onTap: () {
                    removeFromFav(widget.videoPath);
                  },
                  child: Text('Remove from favourites'),
                  value: 'Doge'),
              //  watchlaterDB.values.toList.any((item) => item.laterPath == newFav[index]) ? ,
              PopupMenuItem<String>(
                  onTap: () {},
                  child: Text('Add to Watch Later'),
                  value: 'Lion'),
            ],
        onSelected: (_selected) {
          print(_selected);
        });
  }
}
