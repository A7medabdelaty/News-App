import 'package:flutter/material.dart';
import 'package:news_app/layout/layout.dart';
import 'package:news_app/provider/main_provider.dart';
import 'package:news_app/screens/categories_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => MainProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomeLayout.routeName,
      routes: {
        HomeLayout.routeName: (context) => const HomeLayout(),
        CategoriesScreen.routeName: (context) => const CategoriesScreen(),
        HomeScreen.routeName: (context) =>  HomeScreen(),
        SearchScreen.routeName: (context) => SearchScreen(),
      },
    );
  }
}
