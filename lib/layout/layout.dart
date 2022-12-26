import 'package:flutter/material.dart';
import 'package:news_app/provider/main_provider.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/styles/colors.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);
  static String routeName = 'main layout';

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context);
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/images/pattern.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: customDrawer(context),
        appBar: AppBar(
          backgroundColor: COLOR_PRIMARY,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, SearchScreen.routeName);
              },
            )
          ],
          title: const Text('News App'),
        ),
        body: provider.screens[provider.currentScreenIndex],
      ),
    );
  }
}
