import 'package:flutter/material.dart';
import 'package:news_app/model/NewsModel.dart';
import 'package:news_app/model/SourcesResponse.dart';
import 'package:news_app/network/remote/api_manger.dart';
import 'package:news_app/screens/categories_screen.dart';
import 'package:news_app/screens/home_screen.dart';

class MainProvider extends ChangeNotifier {
  String categoryId = '';
  String sourceId = '';
  String searchKey = '';
  List<Articles> searchList = [];

  Future<SourcesResponse> getSourcesData() async {
    return await APIManger.getSourcesByCategory(categoryId);
  }

  Future<NewsModel> getNewsDataByCategory() async {
    return await APIManger.getNewsArticlesByCategory(categoryId);
  }

  Future<NewsModel> getNewsDataBySource() async {
    return await APIManger.getNewsArticlesBySource(sourceId);
  }

  void setSearchKey(String searchKey) {
    this.searchKey = searchKey;
    notifyListeners();
  }

  void searchForNews(searchKey) async {
    NewsModel data = await APIManger.searchForNews(searchKey);
    data.articles?.forEach((element) {
      searchList.add(element);
    });
  }

  void changeCategoryId(categoryId) {
    this.categoryId = categoryId;
    notifyListeners();
  }

  void changeSource(sourceId) {
    this.sourceId = sourceId;
    notifyListeners();
  }

  int currentScreenIndex = 0;
  List<Widget> screens = [
    const CategoriesScreen(),
    const HomeScreen(),
  ];

  void changeScreen(int index) {
    currentScreenIndex = index;
    notifyListeners();
  }

  int currentSourceIndex = 0;

  void changeSourceIndex(int index, String id) {
    currentSourceIndex = index;
    sourceId = id;
    notifyListeners();
  }
}
