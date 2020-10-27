part of 'news_bloc.dart';

/// 定義有哪些狀態需要通知 UI 更新的介面, 類似 MVP 的 View interface
abstract class NewsState extends Equatable {
  NewsState();

  @override
  List<Object> get props => [];
}

/// 當收到資料時, 透過此 State 傳遞
/// 對應 NewsContract.View 的 onDataReceive()
class NewsReceived extends NewsState {
  final List<News> list;

  NewsReceived(this.list) : super();

  @override
  String toString() {
    return "NewsReceived";
  }
}

/// 對應 NewsContract.View 的 onLoading()
class NewsLoading extends NewsState {
  @override
  String toString() {
    return "NewsLoading";
  }
}

/// 對應 NewsContract.View 的 onFailed()
class FailedFetchData extends NewsState {
  @override
  String toString() {
    return "FailedFetchData";
  }
}
