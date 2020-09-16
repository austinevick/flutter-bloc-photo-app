import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc_gallery_app/models/photos.dart';

class PhotoFullScreen extends StatelessWidget {
  final AudioCache audioCache;
  final Photos photos;
  const PhotoFullScreen({Key key, this.photos, this.audioCache})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Hero(
        tag: photos.id,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            audioCache.play('sound.mp3');
          },
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      photos.original,
                    ))),
          ),
        ),
      ),
    );
  }
}
