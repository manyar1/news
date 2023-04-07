import 'package:flutter/material.dart';
import 'package:news/feature/domain/entities/news_entity.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsEntity news;

  const NewsDetailPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            news.title,
            style: const TextStyle(fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Hero(
                tag: Image.network(news.urlToImage ??
                    'https://img.alicdn.com/imgextra/i2/6000000000654/O1CN01wTeZKY1GhZeUmF7iw_!!6000000000654-0-tbvideo.jpg'),
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.network(news.urlToImage ??
                      'https://img.alicdn.com/imgextra/i2/6000000000654/O1CN01wTeZKY1GhZeUmF7iw_!!6000000000654-0-tbvideo.jpg'),
                )),
            Card(
              elevation: 5,
              margin: const EdgeInsets.only(right: 20, left: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        if (news.autor != null)
                          Text(
                            news.autor.toString(),
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                    const Divider(),
                    if (news.description != null)
                      Text(
                        news.description.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (news.content != null)
                      Text(
                        news.content.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      news.url,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      news.publishedAt.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
