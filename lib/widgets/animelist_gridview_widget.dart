import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/services/mal_services.dart';
import 'list_entry_card_widget.dart';

class AnimeListGridView extends StatefulWidget {
  final String status;
  const AnimeListGridView({super.key, required this.status});

  @override
  State<StatefulWidget> createState() => _AnimeListGridViewState();
}

class _AnimeListGridViewState extends State<AnimeListGridView>
    with AutomaticKeepAliveClientMixin<AnimeListGridView> {
  final List<ListEntryCard> _cardList = [];
  int _offset = 0;
  bool _hasMore = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // load initial 100 entries
    getAnimeCards(widget.status, _offset);
  }

  // refresh function
  Future _refresh() async {
    setState(() {
      _isLoading = false;
      _hasMore = true;
      _offset = 0;
      _cardList.clear();
    });
  }

  void getAnimeCards(status, int offset, {int limit = 100}) {
    if (_isLoading) return;
    _isLoading = true;

    MyAnimelistApi()
        .getUserAnimeList(status: status, offset: offset, limit: limit)
        .then((userAnimeList) {
      List<ListEntryCard> cardList = [];

      cardList = userAnimeList.data
          .map((data) => ListEntryCard(
                animeId: data.node.id,
                imageUrl: data.node.mainPicture.medium,
                animeTitle: data.node.title,
                numEpsWatched: data.listStatus.numEpisodesWatched!,
                numEpisodes: data.node.numEpisodes,
                rating: data.listStatus.score,
                labelMaxLines: 1,
              ))
          .toList();

      setState(() {
        _cardList.addAll(cardList);
        _offset += limit;
        _isLoading = false;

        if (cardList.length < 10) _hasMore = false;
      });
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      Future.delayed(const Duration(seconds: 10)).then((val) {
        _refresh();
      });
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
              getAnimeCards(widget.status, _offset);
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
