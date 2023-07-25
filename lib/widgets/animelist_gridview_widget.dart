import 'package:flutter/material.dart';

import '/services/mal_services.dart';
import 'anime_card_widget.dart';

class AnimeListGridView extends StatefulWidget {
  final String status;
  const AnimeListGridView({super.key, required this.status});

  @override
  State<StatefulWidget> createState() => _AnimeListGridViewState();
}

class _AnimeListGridViewState extends State<AnimeListGridView>
    with AutomaticKeepAliveClientMixin<AnimeListGridView> {
  final List<AnimeCard> _cardList = [];
  int _offset = 0;
  bool _hasMore = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // load initial 100 entries
    getAnimeCards(widget.status, _offset);
  }

  void getAnimeCards(status, int offset, {int limit = 100}) {
    if (_isLoading) return;
    _isLoading = true;

    MyAnimelistApi()
        .getUserAnimeList(status: status, offset: offset, limit: limit)
        .then((userAnimeList) {
      List<AnimeCard> cardList = [];

      cardList = userAnimeList.data
          .map((data) => AnimeCard(
                animeId: data.node.id,
                imageUrl: data.node.mainPicture.medium,
                animeTitle: data.node.title,
                numEpsWatched: data.listStatus.numEpisodesWatched!,
                numEpisodes: data.node.numEpisodes,
                rating: data.listStatus.score,
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
              getAnimeCards(widget.status, _offset);
              return const AnimeCardPlaceholder();
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


// import 'package:flutter/material.dart';

// import '/services/mal_services.dart';
// import 'anime_card.dart';

// class AnimeListGridView extends StatefulWidget {
//   final String status;
//   const AnimeListGridView({super.key, required this.status});

//   @override
//   State<StatefulWidget> createState() => _AnimeListGridViewState();
// }

// class _AnimeListGridViewState extends State<AnimeListGridView>
//     with AutomaticKeepAliveClientMixin<AnimeListGridView> {
//   late Future _getAnimeCards;

//   @override
//   void initState() {
//     _getAnimeCards =
//         getAnimeCards(widget.status != "all" ? widget.status : null);
//     super.initState();
//   }

//   Future<List<AnimeCard>> getAnimeCards(status) async {
//     var userAnimeList = await MyAnimelistApi().getUserAnimeList(status: status);

//     List<AnimeCard> cardList = [];

//     for (var data in userAnimeList.data) {
//       cardList.add(AnimeCard(
//         animeId: data.node.id,
//         imageUrl: data.node.mainPicture.medium,
//         animeTitle: data.node.title,
//         numEpsWatched: data.listStatus.numEpisodesWatched!,
//         numEpisodes: data.node.numEpisodes,
//       ));
//     }

//     return cardList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return FutureBuilder(
//       future: _getAnimeCards,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return GridView.count(
//             crossAxisCount: 4,
//             childAspectRatio: (1 / 2),
//             children: snapshot.data!,
//           );
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Text(snapshot.error.toString()),
//           );
//         } else {
//           // By default, show a loading spinner.
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }
