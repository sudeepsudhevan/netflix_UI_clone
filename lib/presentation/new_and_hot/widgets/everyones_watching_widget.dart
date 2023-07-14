import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix_clone/presentation/widgets/video_widget.dart';

class EveryonesWatchingWidget extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;
  const EveryonesWatchingWidget({
    super.key,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            movieName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        kheight,
        VideoWidget(
          url: posterPath,
        ),
        kheight,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButtonWidget(
              title: "Share",
              icon: Icons.share_sharp,
              iconSize: 25,
              textSize: 16,
            ),
            kwidth,
            CustomButtonWidget(
              title: "More List",
              icon: Icons.add,
              iconSize: 25,
              textSize: 16,
            ),
            kwidth,
            CustomButtonWidget(
              title: "Play",
              icon: Icons.play_arrow,
              iconSize: 25,
              textSize: 16,
            ),
            kwidth,
          ],
        ),
      ],
    );
  }
}
