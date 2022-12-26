import 'package:flutter/material.dart';
import 'package:news_app/provider/main_provider.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/styles/colors.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const String routeName = 'search screen';

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    MainProvider provider = Provider.of<MainProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: COLOR_PRIMARY,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          leadingWidth: 35,
          title: Container(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  provider.searchForNews(value.toString());
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                  splashRadius: 15,
                  icon: Icon(
                    Icons.close,
                    size: 25,
                    color: COLOR_PRIMARY,
                  ),
                  onPressed: () {
                    searchController.text = '';
                  },
                ),
                suffixIcon: Icon(
                  Icons.search,
                  size: 25,
                  color: COLOR_PRIMARY,
                ),
              ),
            ),
          ),
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return articleItemCard(provider.searchList[index]);
          },
          itemCount: provider.searchList.length,
        ));
  }
}
