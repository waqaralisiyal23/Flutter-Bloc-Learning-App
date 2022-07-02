import 'dart:async';
import 'dart:convert';
import 'package:bloclearning/res/constants.dart';
import 'package:http/http.dart' as http;
import 'package:bloclearning/models/news_info.dart';

enum NewsAction { fetch, delete }

class NewsBloc {
  final StreamController<List<Article>> _stateStreamController =
      StreamController<List<Article>>();
  StreamSink<List<Article>> get _newsSink => _stateStreamController.sink;
  Stream<List<Article>> get newsStream => _stateStreamController.stream;

  final StreamController<NewsAction> _eventStreamController =
      StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get _eventStream => _eventStreamController.stream;

  NewsBloc() {
    _eventStream.listen((event) async {
      if (event == NewsAction.fetch) {
        NewsModel? newsModel = await fetchNews();
        if (newsModel != null) {
          _newsSink.add(newsModel.articles);
        } else {
          _newsSink.addError('Something Went Wrong!');
        }
      } else if (event == NewsAction.delete) {}
    });
  }

  Future<NewsModel?> fetchNews() async {
    var client = http.Client();

    try {
      var response = await client
          .get(Uri.parse('${Constants.newsUrl}${Constants.newsApiKey}'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        return NewsModel.fromJson(jsonMap);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
