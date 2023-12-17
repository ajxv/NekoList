import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:neko_list/providers/trending_list_provider.dart';
import 'package:neko_list/screens/entry_details_screen.dart';
import 'package:neko_list/screens/ranking_list_screen.dart';
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

    // final elevatedButtonStyle = ElevatedButton.styleFrom(
    //   foregroundColor: Theme.of(context).colorScheme.onTertiary,
    //   backgroundColor: Theme.of(context).colorScheme.tertiary,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(
    //       Radius.circular(8),
    //     ),
    //   ),
    // );

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
            if (dataProvider.getTopAiringAnimes.isNotEmpty) ...[
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
                            builder: (context) => EntryDetailPage(
                              entryId: item.node.id,
                              isAnime: true,
                            ),
                          ),
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
              // Padding(
              //   padding: const EdgeInsets.only(top: 20, bottom: 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       ElevatedButton(
              //         style: elevatedButtonStyle,
              //         onPressed: () {},
              //         child: const Padding(
              //           padding: EdgeInsets.only(top: 15, bottom: 15),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Icon(Icons.movie),
              //               SizedBox(width: 5),
              //               Text("Anime Ranking"),
              //             ],
              //           ),
              //         ),
              //       ),
              //       ElevatedButton(
              //         style: elevatedButtonStyle,
              //         onPressed: () {},
              //         child: const Padding(
              //           padding: EdgeInsets.only(top: 15, bottom: 15),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Icon(Icons.menu_book_rounded),
              //               SizedBox(width: 5),
              //               Text("Manga Ranking"),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
            // Reccomended animes
            if (!dataProvider.isLoading)
              // show only after loading is done
              ...[
              // seasonal anime
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                child: Text(
                  "This season",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...dataProvider.getSeasonalAnime
                        .sublist(0, 10)
                        .map<Widget>(
                          (e) => ListEntryCard(
                            isAnime: true,
                            entryId: e.node.id,
                            title: e.node.title,
                            imageUrl: e.node.mainPicture.medium,
                            avgRating: e.node.meanScore,
                          ),
                        )
                        .toList(),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RankingListPage(
                            title: 'This Season',
                            data: dataProvider.getSeasonalAnime,
                            isAnime: true,
                          ),
                        ),
                      ),
                      child: const Text("show more"),
                    )
                  ],
                ),
              ),

              // suggested animes
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                child: Text(
                  "Suggested for you",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...dataProvider.getAnimeSuggestions
                        .sublist(0, 10)
                        .map<Widget>(
                          (e) => ListEntryCard(
                            isAnime: true,
                            entryId: e.node.id,
                            title: e.node.title,
                            imageUrl: e.node.mainPicture.medium,
                            avgRating: e.node.meanScore,
                          ),
                        )
                        .toList(),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RankingListPage(
                            title: 'Suggested',
                            data: dataProvider.getAnimeSuggestions,
                            isAnime: true,
                          ),
                        ),
                      ),
                      child: const Text("show more"),
                    )
                  ],
                ),
              ),

              // Top animes
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                child: Text(
                  "Top Animes",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  ...dataProvider.getTopAnimes
                      .sublist(0, 10)
                      .map<Widget>(
                        (e) => ListEntryCard(
                          isAnime: true,
                          entryId: e.node.id,
                          title: e.node.title,
                          imageUrl: e.node.mainPicture.medium,
                          avgRating: e.node.meanScore,
                        ),
                      )
                      .toList(),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RankingListPage(
                          title: 'Top Anime',
                          data: dataProvider.getTopAnimes,
                          isAnime: true,
                        ),
                      ),
                    ),
                    child: const Text("show more"),
                  )
                ]),
              ),

              // Popular animes
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                child: Text(
                  "Popular Animes",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  ...dataProvider.getPopularAnimes
                      .sublist(0, 10)
                      .map<Widget>(
                        (e) => ListEntryCard(
                          isAnime: true,
                          entryId: e.node.id,
                          title: e.node.title,
                          imageUrl: e.node.mainPicture.medium,
                          avgRating: e.node.meanScore,
                        ),
                      )
                      .toList(),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RankingListPage(
                          title: 'Popular Anime',
                          data: dataProvider.getPopularAnimes,
                          isAnime: true,
                        ),
                      ),
                    ),
                    child: const Text("show more"),
                  )
                ]),
              ),

              // Top mangas
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                child: Text(
                  "Top Mangas",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  ...dataProvider.getTopMangas
                      .sublist(0, 10)
                      .map<Widget>(
                        (e) => ListEntryCard(
                          isAnime: false,
                          entryId: e.node.id,
                          title: e.node.title,
                          imageUrl: e.node.mainPicture.medium,
                          avgRating: e.node.meanScore,
                        ),
                      )
                      .toList(),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RankingListPage(
                          title: 'Top Manga',
                          data: dataProvider.getTopMangas,
                          isAnime: true,
                        ),
                      ),
                    ),
                    child: const Text("show more"),
                  )
                ]),
              ),

              // Top manhwas
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                child: Text(
                  "Top Manhwas",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  ...dataProvider.getTopManhwas
                      .sublist(0, 10)
                      .map<Widget>(
                        (e) => ListEntryCard(
                          isAnime: false,
                          entryId: e.node.id,
                          title: e.node.title,
                          imageUrl: e.node.mainPicture.medium,
                          avgRating: e.node.meanScore,
                        ),
                      )
                      .toList(),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RankingListPage(
                          title: 'Top Manhwa',
                          data: dataProvider.getTopManhwas,
                          isAnime: true,
                        ),
                      ),
                    ),
                    child: const Text("show more"),
                  )
                ]),
              ),

              // Popular mangas
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                child: Text(
                  "Popular Mangas",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  ...dataProvider.getPopularMangas
                      .sublist(0, 10)
                      .map<Widget>(
                        (e) => ListEntryCard(
                          isAnime: false,
                          entryId: e.node.id,
                          title: e.node.title,
                          imageUrl: e.node.mainPicture.medium,
                          avgRating: e.node.meanScore,
                        ),
                      )
                      .toList(),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RankingListPage(
                          title: 'Popular Manga',
                          data: dataProvider.getPopularMangas,
                          isAnime: true,
                        ),
                      ),
                    ),
                    child: const Text("show more"),
                  )
                ]),
              ),
            ] else
              // show circular progress indicator if loading
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: LinearProgressIndicator()),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(6, 6),
          )
        ],
      ),
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
