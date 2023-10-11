import 'package:flutter/material.dart';

import '../services/mal_services.dart';
import '../widgets/list_entry_card_widget.dart';

class NekoSearchDelgate extends SearchDelegate {
  String _contentType = "anime";
  @override
  // ignore: overridden_fields
  TextStyle? searchFieldStyle = const TextStyle(fontSize: 16);

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear_rounded),
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_rounded),
      );

  @override
  Widget buildResults(BuildContext context) =>
      SearchGridView(query: query, contentType: _contentType);

  @override
  Widget buildSuggestions(BuildContext context) => StatefulBuilder(
        builder: (context, setState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionChip(
                avatar: _contentType != "anime"
                    ? Icon(Icons.movie,
                        color: Theme.of(context).colorScheme.onPrimary)
                    : Icon(Icons.check_rounded,
                        color: Theme.of(context).colorScheme.onPrimary),
                label: const Text("Anime"),
                labelStyle: const TextStyle(fontSize: 12),
                onPressed: () {
                  setState(() {
                    _contentType = 'anime';
                  });
                },
              ),
              const SizedBox(
                width: 10,
              ),
              ActionChip(
                avatar: _contentType != "manga"
                    ? Icon(Icons.book,
                        color: Theme.of(context).colorScheme.onPrimary)
                    : Icon(Icons.check_rounded,
                        color: Theme.of(context).colorScheme.onPrimary),
                label: const Text("Manga"),
                labelStyle: const TextStyle(fontSize: 12),
                onPressed: () {
                  setState(() {
                    _contentType = 'manga';
                  });
                },
              ),
            ],
          );
        },
      );
}

class SearchGridView extends StatefulWidget {
  final String query;
  final String contentType;
  const SearchGridView({
    super.key,
    required this.contentType,
    required this.query,
  });

  @override
  State<StatefulWidget> createState() => _SearchGridViewState();
}

class _SearchGridViewState extends State<SearchGridView>
    with AutomaticKeepAliveClientMixin<SearchGridView> {
  final List<SimpleListEntryCard> _cardList = [];
  int _offset = 0;
  bool _hasMore = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // load initial 100 entries
    getResults(widget.query, widget.contentType, _offset);
  }

  void getResults(query, contentType, int offset, {int limit = 100}) {
    if (_isLoading) return;
    _isLoading = true;

    MyAnimelistApi()
        .search(
            query: query,
            contentType: contentType,
            offset: offset,
            limit: limit)
        .then((searchResult) {
      List<SimpleListEntryCard> cardList = [];

      cardList = searchResult.data
          .map((data) => SimpleListEntryCard(
                contentType: contentType,
                entryId: data.node.id,
                entryTitle: data.node.title,
                imageUrl: data.node.mainPicture.medium,
              ))
          .toList();

      setState(() {
        _cardList.addAll(cardList);
        _offset += limit;
        _isLoading = false;

        if (cardList.length < 10) _hasMore = false;
      });
    });
  }

  Future _refresh() async {
    setState(() {
      _isLoading = false;
      _hasMore = true;
      _offset = 0;
      _cardList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: GridView.builder(
        itemCount: _cardList.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1 / 2,
        ),
        itemBuilder: (context, index) {
          if (index < _cardList.length) {
            return _cardList[index];
          } else {
            if (_hasMore) {
              getResults(widget.query, widget.contentType, _offset);
              return const ListEntryCardPlaceholder();
            } else {
              return const Center(
                child: Text("(ᓀ ᓀ)"),
              );
            }
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
