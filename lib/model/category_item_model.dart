import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String image;
  Color color;
  String title;
  String source;

  CategoryModel(this.id, this.image, this.color, this.title, this.source);

  static List<CategoryModel> getCategoriesList() {
    List<CategoryModel> categoriesData = [
      CategoryModel('business', 'assets/images/business.png',
          const Color(0xffCF7E48), 'Business','google-news'),
      CategoryModel('entertainment', 'assets/images/ball.png',
          const Color(0xffC91C22), 'Entertainment','google-news'),
      CategoryModel('general', 'assets/images/politics.png',
          const Color(0xff003E90), 'General','google-news'),
      CategoryModel('Health', 'assets/images/health.png',
          const Color(0xffED1E79), 'Health','bbc-news'),
      CategoryModel('science', 'assets/images/science.png',
          const Color(0xffF2D352), 'Science',''),
      CategoryModel('sports', 'assets/images/ball.png', const Color(0xffC91C22),
          'Sports','bbc-sport'),
      CategoryModel('technology', 'assets/images/science.png',
          const Color(0xff003E90), 'Technology','google-news'),
    ];
    return categoriesData;
  }
}
