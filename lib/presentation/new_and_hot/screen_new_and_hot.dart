import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/everyones_watching_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInComingSoon());
    });
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
        body: TabBarView(children: [
          const ComingSoonList(
            key: Key('coming soon'),
          ),
          _buildEveryoneWatching(),
        ]),
      ),
    );
  }

  Widget _buildEveryoneWatching() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (ctx, index) {
        return //EveryonesWatchingWidget();
            SizedBox();
      },
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotAndNewBloc, HotAndNewState>(
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
              return ComingSoonWidget(
                id: movie.id.toString(),
                month: 'NOV',
                day: '11',
                posterPath: '$imageAppendUrl${movie.posterPath}',
                movieName: movie.originalName ?? 'No title',
                description: movie.overview ?? 'No description',
              );
            },
          );
        }
      },
    );
  }
}
