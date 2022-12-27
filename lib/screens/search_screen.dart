import 'package:flutter/material.dart';
import 'package:news_app/provider/main_provider.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/styles/colors.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  static const String routeName = 'search screen';
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                searchController.text.isEmpty
                    ? provider.emptySearchList()
                    : provider.searchForNews(value.toString());
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            provider.searchList.isEmpty
                ? const Center(
                    child: Text(
                    'No Result',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.grey),
                  ))
                : Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return articleItemCard(provider.searchList[index]);
                      },
                      itemCount: provider.searchList.length,
                    ),
                  ),
          ],
        ));
  }
}
