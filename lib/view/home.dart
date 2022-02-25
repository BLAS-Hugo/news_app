

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controller/news_api/news_api_controller.dart';
import 'package:news_app/model/news_info.dart';

class Home extends StatefulWidget {
  const Home({Key? key,}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NewsApiController _apiController = NewsApiController();

  NewsModel news = NewsModel(status: "", totalResults: 0, articles: []);

  late Future<NewsModel> _futureNews;

  @override
  void initState() {
    _futureNews = _apiController.getNews();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
      ),
      body: FutureBuilder<NewsModel>(
          future: _futureNews,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              news = snapshot.data!;
              return ListView.builder(
                itemCount: news.articles.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                news.articles[index].title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(width: 25,),
                            Text(
                                DateFormat('dd.MM.yyyy')
                                .format(news.articles[index].publishedAt),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: 100,
                            width: 400,
                            child: Text(
                              news.articles[index].description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Image.network(
                                news.articles[index].urlToImage,
                                width: 150,
                                errorBuilder: (context, image, e) {
                                  return const SizedBox(width: 150,);
                                },
                            ),
                            const SizedBox(width: 30,),
                            ElevatedButton(
                                onPressed: () {

                                },
                                child: const Text("Lire la suite"),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Loading..."),
              );
            }
          }
      ),
    );
  }
}