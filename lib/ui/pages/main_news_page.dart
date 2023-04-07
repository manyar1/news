import 'package:flutter/material.dart';
import 'package:news/ui/widgets/everything_widget/everything_list.dart';
import 'package:news/ui/widgets/top_headlines_widget/top_headlines_list.dart';

class MainNewsPage extends StatefulWidget {
  const MainNewsPage({super.key});

  @override
  State<MainNewsPage> createState() => _MainNewsPageState();
}

class _MainNewsPageState extends State<MainNewsPage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            _appBarText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            onTap: (index) {
              setState(() {});
            },
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.list_alt),
              ),
              Tab(
                icon: Icon(Icons.list),
              ),
            ],
          )),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          TopHeadlinesList(),
          EverythingList(),
        ],
      ),
    );
  }

  String get _appBarText => _tabController.index == 0 ? 'Top Headlines' : 'Everything';
}
