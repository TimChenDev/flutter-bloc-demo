import 'package:flutter_bloc_app/news/news_remote_data_source.dart';

import 'model/news_list.dart';

/// 負責管理 News 的資料取得
/// 通常 repository 會管理本地端與遠端的資料存取
/// 這裡僅實作遠端資料取得的功能
class NewsRepository {
  final _newsRemoteDataSource = NewsRemoteDataSource();

  Future<List<News>> fetchNewsList() =>
      _newsRemoteDataSource.fetchRemoteNewsList();
}
