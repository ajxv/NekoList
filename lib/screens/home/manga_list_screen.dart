import 'package:flutter/material.dart';
import 'package:neko_list/widgets/list_gridview_widget.dart';

class MangaList extends StatefulWidget {
  const MangaList({super.key});

  @override
  State<StatefulWidget> createState() => _MangaListState();
}

class _MangaListState extends State<MangaList>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<MangaList> {
  late final TabController _tabController;
  final _tabTitles = [
    "Reading",
    "Plan to Read",
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
          // labelColor: Theme.of(context).colorScheme.secondary,
          // unselectedLabelColor: Theme.of(context).colorScheme.primary,
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
                .map(
                  (title) => ListGridView(
                    entryType: 'manga',
                    status: title.replaceAll(' ', '_').toLowerCase(),
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
