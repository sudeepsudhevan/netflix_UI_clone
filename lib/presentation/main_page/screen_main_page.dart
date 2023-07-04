import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/presentation/main_page/widgets/bottom_nav.dart';

class ScreenMainPage extends StatelessWidget {
  const ScreenMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: const Text('Hello, World!'),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
