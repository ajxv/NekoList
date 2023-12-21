import 'package:flutter/material.dart';
import 'package:neko_list/widgets/list_entry_card_widget.dart';

class RankingListPage extends StatelessWidget {
  final String title;
  final dynamic data;
  final bool isAnime;

  const RankingListPage({
    super.key,
    required this.title,
    this.data,
    required this.isAnime,
  });

  @override
  Widget build(BuildContext context) {
    List cardList = data
        .map(
          (e) => ListEntryCard(
            isAnime: isAnime,
            entryId: e.node.id,
            title: e.node.title,
            imageUrl: e.node.mainPicture.medium,
            avgRating: e.node.meanScore,
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: cardList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 9 / 14,
        ),
        itemBuilder: (context, index) {
          return cardList[index];
        },
      ),
    );
  }
}
