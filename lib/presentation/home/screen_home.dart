import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/home/home_bloc.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/home/widgets/background_card.dart';

import 'package:netflix_clone/presentation/home/widgets/number_title_card.dart';

import 'package:netflix_clone/presentation/widgets/main_title_card.dart';

ValueNotifier<bool> ScrollingNotifier = ValueNotifier<bool>(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(
        const GetHomeScreenData(),
      );
    });
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
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2));
                  } else if (state.hasError) {
                    return const Center(
                      child: Text('Error while loading data'),
                    );
                  }
// released past year
                  final _releasedPastYear = state.pastYearMovieList.map((e) {
                    return '$imageAppendUrl${e.posterPath}';
                  }).toList();
                  //_releasedPastYear.shuffle(Random());
// trending now
                  final _trendingNow = state.trendingMovieList.map((e) {
                    return '$imageAppendUrl${e.posterPath}';
                  }).toList();
// tense drama
                  final _tenseDrama = state.tenseDramaMovieList.map((e) {
                    return '$imageAppendUrl${e.posterPath}';
                  }).toList();
                  //_tenseDrama.shuffle();
// south asian
                  final _southAsian = state.southAsianMovieList.map((e) {
                    return '$imageAppendUrl${e.posterPath}';
                  }).toList();
                  //Listview

                  final _tvshowList = state.trendingTvList.map((e) {
                    return '$imageAppendUrl${e.posterPath}';
                  }).toList();

                  return ListView(
                    children: [
                      if (state.trendingMovieList.isNotEmpty)
                        BackgroundCard(
                          coverimageUrl:
                              '$imageAppendUrl${state.trendingMovieList[0].posterPath}',
                        ),
                      if (_releasedPastYear.length >= 10)
                        MainTitleCard(
                          title: 'Released in the Past Year',
                          posterList: _releasedPastYear.sublist(0, 10),
                        ),
                      kheight,
                      if (_trendingNow.length >= 10)
                        MainTitleCard(
                          title: 'Trending Now',
                          posterList: _trendingNow.sublist(0, 10),
                        ),
                      kheight,
                      // middle section
                      if (_tvshowList.length >= 10)
                        NumberTitleCard(
                          postersList: _tvshowList.sublist(0, 10),
                        ),
                      kheight,

                      //middle section end
                      if (_tenseDrama.length >= 10)
                        MainTitleCard(
                          title: 'Tense Drama',
                          posterList: _tenseDrama.sublist(0, 10),
                        ),
                      kheight,
                      if (_southAsian.length >= 10)
                        MainTitleCard(
                          title: 'South Indian Cinema',
                          posterList: _southAsian.sublist(0, 10),
                        ),
                      kheight,
                    ],
                  );
                },
              ),
              ScrollingNotifier.value == true
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      width: double.infinity,
                      height: 90,
                      //color: Colors.black.withOpacity(0.3),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [0.3, 0.9],
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
                              const Image(
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
