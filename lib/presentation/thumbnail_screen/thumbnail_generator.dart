import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../application/videos/videos_bloc.dart';

// ignore: must_be_immutable
class ThumbGenerator extends StatefulWidget {
  ThumbGenerator({
    Key? key,
    required this.videoPath,
  }) : super(key: key);

  String videoPath;

  @override
  State<ThumbGenerator> createState() => _ThumbGeneratorState();
}

class _ThumbGeneratorState extends State<ThumbGenerator> {
  var _thumbnail;

  thumbnail() async {
    var _thumbnailFile = await VideoThumbnail.thumbnailFile(
        video: widget.videoPath,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG);

    _thumbnail = _thumbnailFile;
    context
        .read<ThumbnailBloc>()
        .add(ChangeThumbnailEvent(thumbnail: _thumbnailFile!));
  }

  @override
  void initState() {
    thumbnail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 50,
        width: 80,
        child: BlocBuilder<ThumbnailBloc, ThumbnailState>(
          builder: (context, state) {
            return _thumbnail != null
            ? Image.file(
                File(_thumbnail),
                fit: BoxFit.cover,
              )
            : Image.asset("assets/images/download.jpeg")
            ;
          },
        )
            ,
      ),
    );
  }

  //#########...thumbnail...#########

}
