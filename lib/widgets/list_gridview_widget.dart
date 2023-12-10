import 'package:flutter/material.dart';
import 'package:neko_list/providers/list_provider.dart';
import 'package:provider/provider.dart';

import 'list_entry_card_widget.dart';

class ListGridView extends StatefulWidget {
  final String entryType;
  final String status;
  const ListGridView({
    super.key,
    required this.entryType,
    required this.status,
  });

  @override
  State<StatefulWidget> createState() => _ListGridViewState();
}

class _ListGridViewState extends State<ListGridView>
    with AutomaticKeepAliveClientMixin<ListGridView> {
  // get corressponding provider
  getProvider({listen = true}) {
    return widget.entryType == 'anime'
        ? Provider.of<AnimeListProvider>(context, listen: listen)
        : Provider.of<MangaListProvider>(context, listen: listen);
  }

  // refresh function
  Future _refresh() async {
    // refresh stored data in provider
    getProvider(listen: false).refresh(widget.status);

    // get new data
    getListCards(widget.status);
  }

  // get data
  void getListCards(status, {int limit = 100}) {
    widget.entryType == 'anime'
        ? Provider.of<AnimeListProvider>(context, listen: false)
            .getAnimeCards(status, limit: limit)
        : Provider.of<MangaListProvider>(context, listen: false)
            .getMangaCards(status, limit: limit);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var dataProvider = getProvider();

    var cardList = dataProvider.getCardList(widget.status);

    return RefreshIndicator(
      onRefresh: _refresh,
      child: GridView.builder(
        itemCount: cardList.length + 1,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width ~/ 100,
          childAspectRatio: 11 / 23,
        ),
        itemBuilder: (context, index) {
          if (index < cardList.length) {
            return cardList[index];
          } else {
            if (dataProvider.hasMoreItems(widget.status)) {
              getListCards(widget.status);
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
