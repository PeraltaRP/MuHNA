

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;

  const ChewieListItem({
    required this.videoPlayerController,
    required this.looping,
    Key? key,  
  }):super (key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
   late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: widget.videoPlayerController.value.aspectRatio
      ,
      // aspectRatio: 4/3,
      autoInitialize: true,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.8),
      child: Chewie(controller: _chewieController),
    );
  }

  @override
   dispose() {
    try {
      super.dispose();
      widget.videoPlayerController.dispose();
      _chewieController.dispose();
    } catch (e) {
      throw Exception(e);
    }
  }
}
