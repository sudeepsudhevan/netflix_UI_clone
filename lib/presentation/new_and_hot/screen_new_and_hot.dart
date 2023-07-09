import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/widgets/app_bar_widget.dart';

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
        body: TabBarView(children: [
          _buildTabBarView("Coming Soon"),
          _buildTabBarView("Everyone's Watching"),
        ]),
      ),
    );
  }

  _buildTabBarView(String name) {
    return Center(
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
