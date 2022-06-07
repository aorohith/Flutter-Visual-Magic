//###################...Favourites button Refactoring...########################

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/videos/videos_bloc.dart';
import '../../db/Models/models.dart';
import '../../main.dart';

class Favourite extends StatefulWidget {
  String videoPath;
  int favIndex;
  Favourite({
    Key? key,
    required this.isPressed2,
    required this.videoPath,
    required this.favIndex,
  }) : super(key: key);

  bool isHighlighted = true;
  bool isPressed = true;
  bool isPressed2 = true;

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    if (favDB.values.isNotEmpty) {
      List<Favourites> favList = favDB.values.toList();
      var existingItem = favList
          .where((itemToCheck) => itemToCheck.favVideo == widget.videoPath);
      if (existingItem.isEmpty) {
        widget.isPressed2 = true;
      } else {
        widget.isPressed2 = false;
      }
    }
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHighlightChanged: (value) {
        setState(() {
          widget.isHighlighted = !widget.isHighlighted;
        });
      },
      onTap: () {
        context.read<VideosBloc>().add(FavEvent(fetched: !widget.isPressed2));
          widget.isPressed2 = !widget.isPressed2;
          if (!widget.isPressed2) {
            Favourites favObj = Favourites(favVideo: widget.videoPath);
            favDB.add(favObj);
          } else {
            //delete the fav from db
            final Map<dynamic, Favourites> favMap = favDB.toMap();
            dynamic desiredKey;
            favMap.forEach((key, value) {
              if (value.favVideo == widget.videoPath) {
                desiredKey = key;
              }
            });
            favDB.delete(desiredKey);
          }
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(widget.isHighlighted ? 0 : 2.5),
        height: widget.isHighlighted ? 50 : 45,
        width: widget.isHighlighted ? 50 : 45,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(5, 10),
            ),
          ],
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: BlocBuilder<VideosBloc, VideosState>(
          builder: (context, state) {
            return widget.isPressed2
             ? Icon(
                Icons.favorite_border,
                color: Colors.black.withOpacity(0.6),
              )
            : const Icon(
                Icons.favorite,
                color: Color(0xffED3030),
              )
            ;
          },
        ),
      ),
    );
  }
}
