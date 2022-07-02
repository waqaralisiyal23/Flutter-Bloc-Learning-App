import 'package:bloclearning/codextutorials/part2/news_bloc.dart';
import 'package:bloclearning/models/news_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsBloc newsBloc = NewsBloc();

  @override
  void initState() {
    super.initState();
    newsBloc.eventSink.add(NewsAction.fetch);
  }

  @override
  void dispose() {
    newsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Data'),
      ),
      body: StreamBuilder<List<Article>>(
        stream: newsBloc.newsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var article = snapshot.data![index];
                var formattedTime =
                    DateFormat('dd MMM - HH:mm').format(article.publishedAt);
                return Container(
                  height: 100,
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              article.urlToImage,
                              fit: BoxFit.cover,
                            )),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(formattedTime),
                            Text(
                              article.title,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              article.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
