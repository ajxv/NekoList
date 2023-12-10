import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:neko_list/providers/trending_list_provider.dart';
import 'package:neko_list/screens/anime_details_screen.dart';
import 'package:provider/provider.dart';

import '../../widgets/list_entry_card_widget.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({super.key});

  @override
  State<StatefulWidget> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed>
    with AutomaticKeepAliveClientMixin<HomeFeed> {
  @override
  void initState() {
    super.initState();

    Provider.of<TrendingListProvider>(context, listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var dataProvider = Provider.of<TrendingListProvider>(context);

    return RefreshIndicator(
      onRefresh:
          Provider.of<TrendingListProvider>(context, listen: false).refresh,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // card carousel slider
            if (dataProvider.getTopAiringAnimes.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: const Duration(seconds: 10),
                ),
                items: dataProvider.getTopAiringAnimes
                    .sublist(0, 10)
                    .map<Widget>(
                      (item) => GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  AnimeDetailPage(animeId: item.node.id)),
                        ),
                        child: HorizontalEntryCard(
                          imageUrl: item.node.mainPicture.large,
                          title: item.node.title,
                          subtitle:
                              "(Airing) Rank ${item.ranking.rank.toString()} | ☆ ${item.node.meanScore.toString()}",
                        ),
                      ),
                    )
                    .toList(),
              ),

            // Reccomended animes
            if (!dataProvider.isLoading)
              // show only after loading is done
              ...[
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "Suggested for you",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: dataProvider.getAnimeSuggestions
                      .map<Widget>(
                        (e) => SimpleListEntryCard(
                          contentType: 'anime',
                          entryId: e.node.id,
                          entryTitle: e.node.title,
                          imageUrl: e.node.mainPicture.medium,
                          rating: e.node.meanScore,
                        ),
                      )
                      .toList(),
                ),
              ),

              // Top animes
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "Top Animes",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: dataProvider.getTopAnimes
                      .map<Widget>(
                        (e) => SimpleListEntryCard(
                          contentType: 'anime',
                          entryId: e.node.id,
                          entryTitle: e.node.title,
                          imageUrl: e.node.mainPicture.medium,
                          rating: e.node.meanScore,
                        ),
                      )
                      .toList(),
                ),
              ),

              // Popular animes
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "Popular Animes",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: dataProvider.getPopularAnimes
                      .map<Widget>(
                        (e) => SimpleListEntryCard(
                          contentType: 'anime',
                          entryId: e.node.id,
                          entryTitle: e.node.title,
                          imageUrl: e.node.mainPicture.medium,
                          rating: e.node.meanScore,
                        ),
                      )
                      .toList(),
                ),
              ),

              // Top mangas
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "Top Mangas",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: dataProvider.getTopMangas
                      .map<Widget>(
                        (e) => SimpleListEntryCard(
                          contentType: 'manga',
                          entryId: e.node.id,
                          entryTitle: e.node.title,
                          imageUrl: e.node.mainPicture.medium,
                          rating: e.node.meanScore,
                        ),
                      )
                      .toList(),
                ),
              ),

              // Top manhwas
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "Top Manhwas",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: dataProvider.getTopManhwas
                      .map<Widget>(
                        (e) => SimpleListEntryCard(
                          contentType: 'manga',
                          entryId: e.node.id,
                          entryTitle: e.node.title,
                          imageUrl: e.node.mainPicture.medium,
                          rating: e.node.meanScore,
                        ),
                      )
                      .toList(),
                ),
              ),

              // Popular mangas
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  "Popular Mangas/Manhwas",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: dataProvider.getPopularMangas
                      .map<Widget>(
                        (e) => SimpleListEntryCard(
                          contentType: 'manga',
                          entryId: e.node.id,
                          entryTitle: e.node.title,
                          imageUrl: e.node.mainPicture.medium,
                          rating: e.node.meanScore,
                        ),
                      )
                      .toList(),
                ),
              ),
            ] else
              // show circular progress indicator if loading
              const Padding(
                padding: EdgeInsets.all(10),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HorizontalEntryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final GlobalKey backgroundImageKey = GlobalKey();

  HorizontalEntryCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      height: 200,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                // height: 350,
                key: backgroundImageKey,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.6, 0.90]),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                bottom: 12,
                right: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
