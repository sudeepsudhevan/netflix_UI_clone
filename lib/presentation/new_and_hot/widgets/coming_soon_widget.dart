import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix_clone/presentation/widgets/video_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String description;
  const ComingSoonWidget({
    super.key,
    required this.id,
    required this.month,
    required this.day,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                month,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                day,
                style: const TextStyle(
                  fontSize: 30,
                  letterSpacing: 4,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width - 50,
          height: 450,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VideoWidget(
                url: posterPath,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        movieName,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          //letterSpacing: -2,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  CustomButtonWidget(
                    icon: Icons.notifications_none,
                    title: "Remind Me",
                    iconSize: 20,
                    textSize: 12,
                  ),
                  kwidth20,
                  CustomButtonWidget(
                    icon: Icons.info_outline,
                    title: "Info",
                    iconSize: 20,
                    textSize: 12,
                  ),
                  kwidth
                ],
              ),
              kheight,
              Text("coming on $day $month"),
              kheight,
              Text(
                movieName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              kheight,
              Text(
                description,
                maxLines: 4,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
