import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/home/widgets/number_card.dart';
import 'package:netflix_clone/presentation/home/widgets/number_title_card.dart';

import 'package:netflix_clone/presentation/widgets/main_card.dart';
import 'package:netflix_clone/presentation/widgets/main_title.dart';
import 'package:netflix_clone/presentation/widgets/main_title_card.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MainTitleCard(title: 'Released in the Past Year'),
              MainTitleCard(title: 'Trending Now'),

              // middle section
              NumberTitleCard(),

              //middle section end
              MainTitleCard(title: 'Tense Drama'),
              MainTitleCard(title: 'South Indian Cinema'),
            ],
          ),
        ),
      ),
    );
  }
}
