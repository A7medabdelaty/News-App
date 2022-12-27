import 'package:flutter/material.dart';
import 'package:news_app/model/SourcesResponse.dart';
import 'package:news_app/model/category_item_model.dart';
import 'package:news_app/provider/main_provider.dart';
import 'package:news_app/shared/styles/colors.dart';
import 'package:provider/provider.dart';

import '../../model/NewsModel.dart';

Widget singleSourceTab(Sources source, bool isSelected) {
  return Tab(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2),
        color: isSelected ? Colors.green : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text('${source.name}',
          style: TextStyle(color: isSelected ? Colors.white : Colors.green)),
    ),
  );
}

Widget categoryItem(int index, CategoryModel categoriesList) {
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: categoriesList.color,
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(20),
        topRight: const Radius.circular(20),
        bottomLeft: (index % 2) != 0 ? Radius.zero : const Radius.circular(20),
        bottomRight: (index % 2) == 0 ? Radius.zero : const Radius.circular(20),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          categoriesList.image,
          fit: BoxFit.cover,
          width: 100,
        ),
        Text(
          categoriesList.title,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    ),
  );
}

Widget articleItemCard(Articles model) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            height: 190,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Image.network(
              model.urlToImage ?? '',
              fit: BoxFit.cover,
            )),
        const SizedBox(
          height: 10,
        ),
        Text(
          model.source?.name ?? '',
          style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              overflow: TextOverflow.ellipsis),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          model.title ?? '',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          model.publishedAt?.substring(0, 10) ?? '',
          textAlign: TextAlign.end,
        ),
      ],
    ),
  );
}

Widget customDrawer(context) {
  MainProvider provider = Provider.of<MainProvider>(context);
  return SafeArea(
    child: Drawer(
        child: Column(
      children: [
        Container(
          height: 110,
          color: COLOR_PRIMARY,
          child: const Center(
            child: Text(
              'News App!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  provider.changeScreen(0);
                  Navigator.pop(context);
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.list,
                      size: 30,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: const [
                    Icon(
                      Icons.settings,
                      size: 30,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Settings',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    )),
  );
}
