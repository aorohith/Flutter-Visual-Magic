//###################...Favourites button Refactoring...########################

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/videos/videos_bloc.dart';
import '../../db/Models/models.dart';
import '../../main.dart';

class Favourite extends StatelessWidget {
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
  Widget build(BuildContext context) {
    if (favDB.values.isNotEmpty) {
      List<Favourites> favList = favDB.values.toList();
      var existingItem = favList
          .where((itemToCheck) => itemToCheck.favVideo == videoPath);
      if (existingItem.isEmpty) {
        isPressed2 = true;
      } else {
        isPressed2 = false;
      }
    }
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHighlightChanged: (value) {
      },
      onTap: () {
        context.read<VideosBloc>().add(FavEvent(fetched: !isPressed2));
          isPressed2 = !isPressed2;
          if (!isPressed2) {
            Favourites favObj = Favourites(favVideo: videoPath);
            favDB.add(favObj);
          } else {
            //delete the fav from db
            final Map<dynamic, Favourites> favMap = favDB.toMap();
            dynamic desiredKey;
            favMap.forEach((key, value) {
              if (value.favVideo == videoPath) {
                desiredKey = key;
              }
            });
            favDB.delete(desiredKey);
          }
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(isHighlighted ? 0 : 2.5),
        height: isHighlighted ? 50 : 45,
        width: isHighlighted ? 50 : 45,
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
            return isPressed2
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
