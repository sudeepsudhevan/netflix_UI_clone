import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/home/widgets/background_card.dart';
import 'package:netflix_clone/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix_clone/presentation/home/widgets/number_card.dart';
import 'package:netflix_clone/presentation/home/widgets/number_title_card.dart';

import 'package:netflix_clone/presentation/widgets/main_card.dart';
import 'package:netflix_clone/presentation/widgets/main_title.dart';
import 'package:netflix_clone/presentation/widgets/main_title_card.dart';

ValueNotifier<bool> ScrollingNotifier = ValueNotifier<bool>(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: ScrollingNotifier,
      builder: (BuildContext context, index, _) {
        return NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final ScrollDirection direction = notification.direction;
            if (direction == ScrollDirection.forward) {
              ScrollingNotifier.value = true;
              // print('scrolling up');
            } else if (direction == ScrollDirection.reverse) {
              ScrollingNotifier.value = false;
              // print('scrolling down');
            }
            return true;
          },
          child: Stack(
            children: [
              ListView(
                children: const [
                  BackgroundCard(),
                  MainTitleCard(title: 'Released in the Past Year'),
                  kheight,
                  MainTitleCard(title: 'Trending Now'),
                  kheight,
                  // middle section
                  NumberTitleCard(),
                  kheight,

                  //middle section end
                  MainTitleCard(title: 'Tense Drama'),
                  kheight,
                  MainTitleCard(title: 'South Indian Cinema'),
                  kheight,
                ],
              ),
              ScrollingNotifier.value == true
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      width: double.infinity,
                      height: 90,
                      //color: Colors.black.withOpacity(0.3),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.2, 0.9],
                          colors: [
                            Colors.black,
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image(
                                width: 60,
                                height: 60,
                                image: AssetImage(
                                  'assets/images/netflix_logo.png',
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.cast,
                                //color: kcolorwhite,
                                size: 30,
                              ),
                              kwidth,
                              Container(
                                width: 30,
                                height: 30,
                                color: Colors.blue,
                              ),
                              kwidth,
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'TV Shows',
                                style: kHomeTitletextstyle,
                              ),
                              Text(
                                'Movies',
                                style: kHomeTitletextstyle,
                              ),
                              Text(
                                'Categories',
                                style: kHomeTitletextstyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : kheight,
            ],
          ),
        );
      },
    ));
  }
}
