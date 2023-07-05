import 'dart:math';

import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({super.key});

  final List imageList = [
    "https://image.tmdb.org/t/p/w1280/fiVW06jE7z9YnO4trhaMEdclSiC.jpg",
    "https://image.tmdb.org/t/p/w1280/6KErczPBROQty7QoIsaa6wJYXZi.jpg",
    "https://image.tmdb.org/t/p/w1280/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarWidget(
          title: "Downloads",
        ),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                //color: kcolorwhite,
              ),
              Text("Smart Downloads"),
            ],
          ),
          const Text("Introducing Downloads for you"),
          const Text(
              "We'll download a personalized selection of movies and shows for you, so there's always something to watch on your phone."),
          Container(
            width: size.width,
            height: size.width,
            //color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: size.width * 0.37,
                ),
                DownloadsImageWidget(
                  size: Size(size.width * 0.4, size.width * 0.58),
                  imageList: imageList[2],
                  angle: 20,
                  margin: const EdgeInsets.only(left: 130, bottom: 50),
                ),
                DownloadsImageWidget(
                  size: Size(size.width * 0.4, size.width * 0.58),
                  imageList: imageList[0],
                  angle: -20,
                  margin: const EdgeInsets.only(right: 130, bottom: 50),
                ),
                DownloadsImageWidget(
                  size: Size(size.width * 0.45, size.width * 0.64),
                  imageList: imageList[1],
                  radius: 25,
                  margin: const EdgeInsets.only(bottom: 10),
                ),
              ],
            ),
          ),
          MaterialButton(
            color: buttoncolorblue,
            onPressed: () {},
            child: const Text(
              "Set up",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          MaterialButton(
            color: kcolorwhite,
            onPressed: () {},
            child: const Text(
              "See what you can download",
              style: TextStyle(
                color: kblackColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget({
    super.key,
    required this.imageList,
    this.angle = 0,
    required this.margin,
    required this.size,
    this.radius = 20,
  });

  final String imageList;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          margin: margin,
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              image: NetworkImage(
                imageList,
              ),
              //fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
