import 'package:flutter/material.dart';

class MangaList extends StatefulWidget {
  const MangaList({super.key});

  @override
  State<StatefulWidget> createState() => _MangaListState();
}

class _MangaListState extends State<MangaList> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const <Widget>[
            Tab(
              text: "watching",
            ),
            Tab(
              text: "plan to watch",
            ),
            Tab(
              text: "on hold",
            ),
            Tab(
              text: "completed",
            ),
            Tab(
              text: "dropped",
            ),
            Tab(
              text: "all",
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const <Widget>[
              Center(child: Text("1")),
              Center(child: Text("2")),
              Center(child: Text("3")),
              Center(child: Text("4")),
              Center(child: Text("5")),
              Center(child: Text("6")),
            ],
          ),
        )
      ],
    );
  }
}
