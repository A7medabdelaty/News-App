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
  List<Sources> sourcesList = [];

  Future<SourcesResponse> getSourcesData(categoryId) async {
    this.categoryId = categoryId;
    sourcesList = [];
    sourceId = '';
    var data = await APIManger.getSourcesByCategory(categoryId);
    data.sources?.forEach((element) {
      sourcesList.add(element);
    });
    notifyListeners();
    return data;
  }

  Future<NewsModel> getNewsDataByCategory() async {
    return await APIManger.getNewsArticlesByCategory(categoryId);
  }

  Future<NewsModel> getNewsDataBySource() async {
    if (sourceId.isEmpty) {
      sourceId = sourcesList[0].id ?? '';
    }
    return await APIManger.getNewsArticlesBySource(sourceId);
  }

  void setSearchKey(String searchKey) {
    this.searchKey = searchKey;
    notifyListeners();
  }

  void searchForNews(searchKey) async {
    NewsModel data = await APIManger.searchForNews(searchKey);
    searchList = [];
    data.articles?.forEach((element) {
      searchList.add(element);
    });
    notifyListeners();
  }

  void emptySearchList() {
    searchList = [];
    notifyListeners();
  }

  void changeSource(sourceId) {
    this.sourceId = sourceId;
    notifyListeners();
  }

  int currentScreenIndex = 0;
  List<Widget> screens = [
    const CategoriesScreen(),
    HomeScreen(),
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
