import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService extends GetxController{
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = '8b1a01a392c64c58a8d8dfae800a299a';
  static const String _category = 'business';
  static const String _country = 'us';

  RxList<Article> articles = RxList<Article>([]);
  RxBool isLoading = false.obs;
  static final http.Client _client = http.Client();

  Future<List<Article>> fetchArticles() async{
    try{
      isLoading.value = false;
      final response = await _client.get(Uri.parse('${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey'));
      if(response.statusCode == 200){
        final jsonData = response.body;
        final articlesResult = ArticlesResult.fromJson(json.decode(jsonData));
        articles.value = articlesResult.articles;
        return articlesResult.articles;
      } else {
        print("Request failed with status: ${response.statusCode}");
        return [];
      }
    } catch (e){
      print('An error occurred: $e');
      return [];
    } finally {
      isLoading.value = false;
    }
  }
}

class ArticlesResult{
  final String status;
  final int totalResults;
  final List<Article> articles;
  ArticlesResult({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory ArticlesResult.fromJson(Map<String, dynamic> json) => ArticlesResult(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<Article>.from((json["articles"] as List)
        .map((x) => Article.fromJson(x))
        .where((article) =>
        article.author != null &&
        article.description != null &&
        article.urlToImage != null &&
        article.publishedAt != null &&
        article.content != null)),
  );
}



class Article {
  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;
  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    author: json["author"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    urlToImage: json["urlToImage"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"],
  );

}