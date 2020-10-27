import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import 'model/news_list.dart';

/// News 的遠端資料取得
class NewsRemoteDataSource {
  // 以中研院新聞稿為例
  final String apiUrl = "https://www.sinica.edu.tw/getJsonData.php?id=2";

  final Client _client;

  NewsRemoteDataSource({Client client}) : _client = client ?? Client();

  /// 進行 http 的請求任務
  Future<List<News>> fetchRemoteNewsList() async {

    // 延遲 3 秒, 目的是展示 NewsLoading State 變換的效果
    await Future.delayed(Duration(seconds: 3));

    // 透過 client 這個物件進行 http 的 get request
    final response = await _client.get(apiUrl);
    // if success
    if (response.statusCode == 200) {
      // 將回傳資料以 json.decode 解析成 mapping 的物件
      // 再將物件由 NewsList 的建構子進行資料配對與建立物件
      NewsList newsList = NewsList.fromJson(json.decode(response.body));
      // 回傳 List
      return newsList.newsList;
    } else {
      throw Exception('not ok');
    }
  }
}
