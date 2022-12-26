import 'package:flutter/material.dart';
import 'package:news_app/model/category_item_model.dart';
import 'package:news_app/provider/main_provider.dart';
import 'package:provider/provider.dart';

import '../shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  static const String routeName = 'categoriesScreen';

  @override
  Widget build(BuildContext context) {
    MainProvider provider = Provider.of<MainProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Pick your category of interest',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                var category = CategoryModel.getCategoriesList()[index];
                return InkWell(
                  onTap: () {
                    provider.changeCategoryId(category.id);
                    provider.changeScreen(1);
                  },
                  child: categoryItem(
                      index, category),
                );
              },
              itemCount: 7,
            ),
          )
        ],
      ),
    );
  }


}
