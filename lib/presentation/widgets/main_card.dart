import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';

class MainCard2 extends StatelessWidget {
  const MainCard2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
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
    );
  }
}
