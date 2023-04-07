import 'package:flutter/material.dart';
import 'package:news/feature/domain/entities/news_entity.dart';
import 'package:news/ui/pages/news_page.dart';

class NewsItem extends StatelessWidget {
  final NewsEntity news;
  const NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          elevation: 5,
          margin: const EdgeInsets.only(right: 20, left: 20),
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(255, 41, 39, 39), width: 1),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10)),
          ),
          color: Colors.grey,
          child: ListTile(
            leading: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewsDetailPage(
                      news: news,
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: 50,
                height: 60,
                child: Image.network(news.urlToImage ??
                    'https://img.alicdn.com/imgextra/i2/6000000000654/O1CN01wTeZKY1GhZeUmF7iw_!!6000000000654-0-tbvideo.jpg'),
              ),
            ),
            title: Text(
              news.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  news.publishedAt.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
