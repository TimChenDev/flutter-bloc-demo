/// API 回傳的資料架構
/// 此案例回傳的是一個 JSON 陣列, 裡面直接放 News 物件
class NewsList {
  List<News> newsList;

  /// Named constructor
  /// 帶名稱的建構子, 傳入一個 dynamic map JSON 物件
  NewsList.fromJson(List<dynamic> parseJson) {
    // 將傳入的 dynamic map JSON 物件透過 index 逐一取出資料
    List<News> tmpList = List();
    for (var tmpItem in parseJson) {
      News news = News(tmpItem);
      tmpList.add(news);
    }
    // 再放入物件裡對應的變數
    newsList = tmpList;
  }
}

/// News 物件架構
class News {
  String title;
  String titleEn;

  /// 建構子
  News(result) {
    // 將傳入的 dynamic map JSON 物件透過 key 逐一取出資料
    // 再放入物件裡對應的變數
    title = result['title'];
    titleEn = result['titleEn'];
  }
}
