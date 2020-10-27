import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_app/news/model/news_list.dart';
import 'package:meta/meta.dart';

import '../news_repository.dart';

part 'news_event.dart';

part 'news_state.dart';

/// 邏輯的總流程管理, 類似 MVP 的 presenter 的 implement
/// 對應 NewsPresenter
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({@required NewsRepository newsRepository})
      : assert(newsRepository != null),
        _newsRepository = newsRepository,
        super(null);

  final NewsRepository _newsRepository;

  /// 管理收到的 Event 和對應的處置
  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is FetchNewsData) {
      yield* _mapFetchNewsData();
    }
  }

  /// 將 FetchNewsData 這個 Event 應該要做的事情
  /// 詳細邏輯與流程定義在這裡
  /// 對應 NewsPresenter 的 fun fetchNewsData()
  Stream<NewsState> _mapFetchNewsData() async* {
    // 推送 NewsLoading() 的 State, 通知 UI 顯示 loading 狀態
    yield NewsLoading();
    try {
      // 由 repository 進行資料的取得, 使用 await 異步等候資料回傳
      final _newsList = await _newsRepository.fetchNewsList();
      // 執行完畢收到 list 後才繼續往下執行
      // 推送 NewsReceived() 的 State, 將資料推送到 UI 更新 State
      yield NewsReceived(_newsList);
    } catch (_) {
      // 如果失敗, 推送失敗的 State 給 UI
      yield FailedFetchData();
    }
  }
}
