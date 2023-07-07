import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: 40,
              height: 150,
            ),
            Container(
              width: 130,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: kborderRadius10,
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w1280/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 7,
          bottom: -24,
          child: BorderedText(
            strokeWidth: 3,
            strokeColor: Colors.white,
            child: Text(
              "${index + 1}",
              style: const TextStyle(
                fontSize: 135,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                decorationColor: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
