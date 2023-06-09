import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/ui/pages/bookmark_page.dart';
import 'package:news/ui/pages/main_news_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: const Color.fromRGBO(44, 42, 42, 1),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list_alt,
                color: Colors.white,
              ),
              label: 'Новости',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.turned_in_not_outlined,
                color: Colors.white,
              ),
              label: 'Закладки',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          late final CupertinoTabView returnValue;
          switch (index) {
            case 0:
              returnValue = CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                  child: MainNewsPage(),
                );
              });
              break;
            case 1:
              returnValue = CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                  child: BookmarkPage(),
                );
              });
              break;
            case 2:
          }
          return returnValue;
        });
  }
}
