import 'package:flutter/material.dart';

import '../../widgets/animelist_gridview_widget.dart';

class AnimeList extends StatefulWidget {
  const AnimeList({super.key});

  @override
  State<StatefulWidget> createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<AnimeList> {
  late final TabController _tabController;
  final _tabTitles = [
    "Watching",
    "Plan to Watch",
    "On Hold",
    "Completed",
    "Dropped",
    "All"
  ]; // used for both TabBar and TabBarView. Edit Carefully!!

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
    super.build(context);
    return Column(
      children: <Widget>[
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabTitles
              .map((title) => Tab(
                    text: title,
                  ))
              .toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            // List of AnimeGridView s
            children: _tabTitles
                .map((title) => AnimeListGridView(
                    status: title.replaceAll(' ', '_').toLowerCase()))
                .toList(),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
