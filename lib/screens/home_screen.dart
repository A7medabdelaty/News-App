import 'package:flutter/material.dart';
import 'package:news_app/model/NewsModel.dart';
import 'package:news_app/provider/main_provider.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const String routeName = 'homeScreen';

  //List<Sources>? sources;

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context);
    return Column(
      children: [
        Builder(
          builder: (context) {
            List<Widget>? tabs = provider.sourcesList.map((e) {
              return singleSourceTab(
                  e, provider.sourcesList[provider.currentSourceIndex] == e);
            }).toList();

            return DefaultTabController(
                length: provider.sourcesList.length,
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  onTap: (index) {
                    provider.changeSourceIndex(
                        index, provider.sourcesList[index].id!);
                  },
                  isScrollable: true,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                  tabs: tabs,
                ));
          },
        ),
        Expanded(
          child: FutureBuilder(
            future: provider.getNewsDataBySource(),
            builder: (context, snapshot) {
              List<Articles>? articles = snapshot.data?.articles;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return articles == null
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return articleItemCard(articles[index]);
                      },
                      itemCount: articles.length,
                    );
            },
          ),
        )
      ],
    );
  }
}
