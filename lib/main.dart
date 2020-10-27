import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/news/news_repository.dart';

import 'news/bloc/news_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NewsBloc _newsBloc;
  final NewsRepository _newsRepository = NewsRepository();

  @override
  void initState() {
    // 初始化 Bloc, 建構子傳入一個 repository
    _newsBloc = NewsBloc(newsRepository: _newsRepository);
    /// Notifies the [Bloc] of a new [event] which triggers [mapEventToState].
    _newsBloc.add(FetchNewsData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // UI 的基本元件需要由 BlocBuilder 建立
    return BlocBuilder<NewsBloc, NewsState>(
      cubit: _newsBloc,
      builder: (context, state) {
        // 根據 Bloc 通知的 state 更新, 進行不同的 UI 設定
        if (state is NewsLoading) {
          return Text('資料正在下載中',
              style: TextStyle(
                  color: Colors.black54, backgroundColor: Colors.yellow));
        } else if (state is FailedFetchData) {
          return Text('資料下載失敗',
              style: TextStyle(
                  color: Colors.black54, backgroundColor: Colors.yellow));
        } else if (state is NewsReceived) {
          String tmpText =
              "資料下載完成, 共 ${state.list.length} 筆資料, 第一筆資料的標題為 ${state.list[0].title}";
          return Text(tmpText,
              style: TextStyle(
                  color: Colors.black54, backgroundColor: Colors.yellow));
        }
        return Text('Nothing happened',
            style: TextStyle(
                color: Colors.black54, backgroundColor: Colors.yellow));
      },
    );
  }
}
