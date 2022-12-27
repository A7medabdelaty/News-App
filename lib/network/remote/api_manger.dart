import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/NewsModel.dart';
import 'package:news_app/model/SourcesResponse.dart';
import 'package:news_app/shared/components/constants.dart';

class APIManger {
  static Future<SourcesResponse> getSourcesByCategory(String categoryID) async {
    Uri uri = Uri.https(BASE_URL, 'v2/top-headlines/sources',
        {'apiKey': API_KEY, 'category': categoryID});
    Response response = await http.get(uri);
    dynamic json = jsonDecode(response.body);
    return SourcesResponse.fromJson(json);
  }

  static Future<NewsModel> getNewsArticlesByCategory(
      String categoryID) async {
    Uri uri = Uri.https(BASE_URL, 'v2/top-headlines/', {
      'apiKey': API_KEY,
      'category': categoryID,
    });
    Response response = await http.get(uri);
    dynamic json = jsonDecode(response.body);
    return NewsModel.fromJson(json);
  }
  static Future<NewsModel> getNewsArticlesBySource(
      String source) async {
    Uri uri = Uri.https(BASE_URL, 'v2/top-headlines/', {
      'apiKey': API_KEY,
      'sources': source
    });
    Response response = await http.get(uri);
    dynamic json = jsonDecode(response.body);
    return NewsModel.fromJson(json);
  }

  static Future<NewsModel> searchForNews(String key)async {
    Uri uri = Uri.https(BASE_URL, 'v2/everything/', {
      'apiKey': API_KEY,
      'q':key
    });
    Response response = await http.get(uri);
    dynamic json = jsonDecode(response.body);
    return NewsModel.fromJson(json);
  }
}
