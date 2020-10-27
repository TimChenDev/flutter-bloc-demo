part of 'news_bloc.dart';

/// 定義 bloc 要做的事情的介面, 類似 MVP 的 presenter interface
/// Android 的 presenter interface 定義 function
/// 這裡定義 class, event class 是 NewsBloc 用來識別任務的工具
abstract class NewsEvent extends Equatable {
  NewsEvent();

  @override
  List<Object> get props => [];
}

/// 進行新聞稿資料的取得
/// 對應 Presenter 的 fun fetchNewsData()
class FetchNewsData extends NewsEvent {
  FetchNewsData() : super();

  @override
  String toString() {
    return "Fetch news list";
  }
}
