import 'package:flutter/material.dart';
import 'package:news_app/model/NewsModel.dart';
import 'package:news_app/model/SourcesResponse.dart';
import 'package:news_app/provider/main_provider.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = 'homeScreen';

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context);
    return Column(
      children: [
        FutureBuilder(
          future: provider.getSourcesData(),
          builder: (context, snapshot) {
            List<Sources>? sources = snapshot.data?.sources;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              print(snapshot.error);
              print(snapshot.stackTrace);
              return const Center(child: Text('Error, Please try again later'));
            }
            List<Widget>? tabs = sources
                ?.map((e) {return singleSourceTab(
                    e, sources[provider.currentSourceIndex] == e);
                })
                .toList();
            return DefaultTabController(
                length: sources?.length ?? 0,
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  onTap: (index) {
                    provider.changeSourceIndex(index, sources?[index].id ?? '');
                  },
                  isScrollable: true,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                  tabs: tabs ?? [],
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
              if (snapshot.hasError) {
                return const Text('Error,Please try again later');
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
