import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/everyones_watching_widget.dart';
import 'package:intl/intl.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(
              "New & Hot",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            actions: [
              const Icon(
                Icons.cast,
                //color: kcolorwhite,
                size: 30,
              ),
              kwidth,
              Container(
                width: 30,
                height: 20,
                color: Colors.blue,
              ),
              kwidth,
            ],
            bottom: TabBar(
              labelColor: kblackColor,
              isScrollable: true,
              unselectedLabelColor: kcolorwhite,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: kcolorwhite,
              ),
              tabs: const [
                Tab(
                  text: "🍿 Coming Soon",
                ),
                Tab(
                  text: "👀 Everyone's Watching",
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(children: [
          ComingSoonList(
            key: Key('coming soon'),
          ),
          EveryonesWatchingList(
            key: Key('everyone_is_watching'),
          ),
        ]),
      ),
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInComingSoon());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text("Error while loading data"),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(child: Text("No data found"));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              shrinkWrap: true,
              itemCount: state.comingSoonList.length,
              itemBuilder: (ctx, index) {
                final movie = state.comingSoonList[index];
                if (movie.id == null) {
                  return const SizedBox();
                }
                if (movie.posterPath == null) {
                  return const SizedBox.shrink();
                }
                ;

                String month = '';
                String day = '';
                try {
                  final _date = DateTime.tryParse(movie.releaseDate!);

                  final formatedDate =
                      DateFormat.yMMMMd('en_US').format(_date!);
                  month = formatedDate
                      .split(' ')
                      .first
                      .substring(0, 3)
                      .toUpperCase();
                  day = formatedDate.split(' ')[1];
                } catch (_) {
                  month = '';
                  day = '';
                }
                return ComingSoonWidget(
                  id: movie.id.toString(),
                  month: month,
                  day: day,
                  posterPath: '$imageAppendUrl${movie.posterPath}',
                  movieName: movie.originalTitle ?? 'No title',
                  description: movie.overview ?? 'No description',
                );
              },
            );
          }
        },
      ),
    );
  }
}

class EveryonesWatchingList extends StatelessWidget {
  const EveryonesWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryoneIsWatching());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInEveryoneIsWatching());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text("Error while loading data"),
            );
          } else if (state.everyOneIsWatchingList.isEmpty) {
            return const Center(child: Text("No data found"));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              itemCount: state.everyOneIsWatchingList.length,
              itemBuilder: (ctx, index) {
                final movie = state.everyOneIsWatchingList[index];
                if (movie.id == null) {
                  return const SizedBox();
                }
                ;

                final tv = state.everyOneIsWatchingList[index];

                return EveryonesWatchingWidget(
                  posterPath: '$imageAppendUrl${tv.posterPath}',
                  movieName: tv.originalName ?? 'No title',
                  description: tv.overview ?? 'No description',
                );
              },
            );
          }
        },
      ),
    );
  }
}
